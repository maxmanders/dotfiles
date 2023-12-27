-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.g.mapleader = ","
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.wo.relativenumber = true
vim.opt.hls = false
vim.api.nvim_set_option("clipboard","unnamed")
