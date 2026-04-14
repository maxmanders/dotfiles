require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-l>", function()
  vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
end, {
  desc = "Copilot Accept",
  replace_keycodes = true,
  nowait=true,
  silent=true,
  expr=true,
  noremap=true,
  }
)

map("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial" })
map("n", "<leader>gg", "<cmd> LazyGit<CR>", { desc = "Toggle LazyGit" })

map("v", ">", ">gv", { desc = "Indent text" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Bubble lines up/down
map("n", "]e", "<cmd>m .+1<CR>==",  { desc = "Move line down" })
map("n", "[e", "<cmd>m .-2<CR>==",  { desc = "Move line up" })
map("v", "]e", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "[e", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
