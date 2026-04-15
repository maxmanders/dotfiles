require "nvchad.autocmds"

vim.filetype.add({
  extension = {
    hujson = "jsonc",
  },
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.yaml.gotmpl",
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})
