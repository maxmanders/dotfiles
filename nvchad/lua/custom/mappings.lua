---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>gg"] = { "<cmd> LazyGit<CR>", "Toggle LazyGit" },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

M.copilot = {
  i = {
    ["<C-l>"] = {
      function()
        vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
      end,
      "Copilot Accept",
      {replace_keycodes = true, nowait=true, silent=true, expr=true, noremap=true}
    }
  }
}

-- more keybinds!
M.disabled = {
    i =  {
      ["<C-h>"] = "",
    }
}

return M
