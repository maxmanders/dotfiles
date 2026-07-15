require "nvchad.autocmds"

vim.api.nvim_create_autocmd("QuitPre", {
  callback = function()
    local wins = vim.api.nvim_list_wins()
    local tree_wins, float_wins = 0, 0
    for _, w in ipairs(wins) do
      if vim.api.nvim_win_get_config(w).relative ~= "" then
        float_wins = float_wins + 1
      elseif vim.bo[vim.api.nvim_win_get_buf(w)].filetype == "NvimTree" then
        tree_wins = tree_wins + 1
      end
    end
    if #wins - float_wins - tree_wins == 1 then
      vim.cmd "NvimTreeClose"
    end
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function(data)
    local real_file = vim.fn.filereadable(data.file) == 1
    local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
    if not real_file and not no_name then return end
    -- Skip when opened as $EDITOR by git (commit messages, rebase todo, etc.)
    if data.file:find("[/\\]%.git[/\\]", 1) then return end
    -- Skip when opened as $EDITOR by gh or other tools (PR/issue bodies in tmp)
    local tmpdir = (os.getenv("TMPDIR") or "/tmp"):gsub("/$", "")
    if data.file:find("^/tmp/", 1, true) or data.file:find("^" .. vim.pesc(tmpdir) .. "/", 1) then return end
    require("nvim-tree.api").tree.toggle({ focus = false, find_file = true })
  end,
})

vim.api.nvim_create_autocmd("UIEnter", {
  once = true,
  callback = function()
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#60778F" })
  end,
})

-- Re-enable swap files for temp directory files (e.g. buffers opened by gh pr create, git commit, etc.)
-- so that editor crashes don't lose the PR body or commit message.
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
  callback = function(args)
    local file = args.file
    if file == "" then return end
    local tmpdir = (os.getenv("TMPDIR") or "/tmp"):gsub("/$", "")
    if file:find("^/tmp/", 1, true) or file:find("^" .. vim.pesc(tmpdir) .. "/", 1) then
      vim.opt_local.swapfile = true
    end
  end,
})

vim.filetype.add({
  extension = {
    hujson = "jsonc",
  },
})

vim.filetype.add({
  extension = {
    tf = "terraform",
    tfvars = "terraform-vars",
    hcl = "hcl",
  },
})

local function helm_chart_root(path)
  if vim.fn.fnamemodify(path, ":t") == "Chart.yaml" then return nil end
  local dir = vim.fn.fnamemodify(path, ":h")
  while dir ~= "/" do
    if vim.fn.filereadable(dir .. "/Chart.yaml") == 1 then return dir end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
end

vim.filetype.add({
  pattern = {
    [".*%.yaml%.gotmpl$"] = function(path)
      return helm_chart_root(path) and "helm" or "yaml"
    end,
    [".*%.yaml$"] = function(path)
      if helm_chart_root(path) then return "helm" end
    end,
  },
})

-- The helm treesitter grammar uses injection.combined for YAML (spanning the whole file).
-- This causes the incremental updater to not re-highlight newly typed template nodes.
-- Force a full invalidate + reparse on every text change so highlights stay current.
vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "helm" then return end
    local parser = vim.treesitter.get_parser(args.buf, "helm", { error = false })
    if parser then
      parser:invalidate(true)
      parser:parse()
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "helm",
  callback = function(args)
    local function chart_root(file)
      local dir = vim.fn.fnamemodify(file, ":h")
      while dir ~= "/" do
        if vim.fn.filereadable(dir .. "/Chart.yaml") == 1 then return dir end
        dir = vim.fn.fnamemodify(dir, ":h")
      end
    end

    local opts = function(desc) return { buffer = args.buf, silent = true, desc = desc } end

    vim.keymap.set("n", "<leader>Hl", function()
      local root = chart_root(vim.api.nvim_buf_get_name(args.buf))
      if root then vim.cmd("!" .. "helm lint " .. vim.fn.shellescape(root)) end
    end, opts("Helm lint"))

    vim.keymap.set("n", "<leader>Ht", function()
      local root = chart_root(vim.api.nvim_buf_get_name(args.buf))
      if root then
        local name = vim.fn.fnamemodify(root, ":t")
        vim.cmd("new | read !helm template " .. vim.fn.shellescape(name) .. " " .. vim.fn.shellescape(root))
      end
    end, opts("Helm template (dry run)"))

    vim.keymap.set("n", "<leader>Hv", function()
      local root = chart_root(vim.api.nvim_buf_get_name(args.buf))
      if root then vim.cmd("edit " .. root .. "/values.yaml") end
    end, opts("Open values.yaml"))

    vim.keymap.set("n", "<leader>Hc", function()
      local root = chart_root(vim.api.nvim_buf_get_name(args.buf))
      if root then vim.cmd("edit " .. root .. "/Chart.yaml") end
    end, opts("Open Chart.yaml"))
  end,
})
