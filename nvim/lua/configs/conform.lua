local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
  },

  format_on_save = function(bufnr)
    if vim.list_contains({ "terraform", "terraform-vars" }, vim.bo[bufnr].filetype) then
      return { timeout_ms = 500, lsp_fallback = true }
    end
  end,
}

return options
