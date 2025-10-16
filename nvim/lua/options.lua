require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.wo.relativenumber = true
vim.opt.hls = false
vim.opt.mouse = ""

vim.o.foldenable = false

-- autoformat Go files on save
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "just",
  callback = function()
    vim.bo.commentstring = "# %s"
  end
})

-- Create an autocommand for "BufRead" events
vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*.yaml.gotmpl", "*.gotmpl" },
  callback = function()
    vim.opt.filetype = "yaml"
  end
})
