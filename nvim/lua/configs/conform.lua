local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
    yaml = { "yamlfmt" },
    helm = {},
    json = { "prettier" },
    jsonc = { "prettier" },
    markdown = { "prettier" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
    hcl = { "terraform_fmt" },
  },

  format_on_save = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    -- terraform_fmt can be slow when initialising providers
    local timeout = vim.list_contains({ "terraform", "terraform-vars", "hcl" }, ft) and 5000
      or vim.list_contains({ "yaml", "json", "jsonc", "markdown", "helm" }, ft) and 2000
      or 500
    return { timeout_ms = timeout, lsp_fallback = true }
  end,
}

return options
