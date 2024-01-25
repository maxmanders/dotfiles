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

-- more keybinds!
M.disabled = {
    i =  {
      ["<C-h>"] = "",
    }
}

return M
