require "nvchad.autocmds"

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

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.yaml.gotmpl",
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})
