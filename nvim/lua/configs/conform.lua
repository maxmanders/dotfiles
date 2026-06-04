local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format" },
    yaml = { "prettier" },
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
    -- terraform_fmt can be slow when initialising providers
    local timeout = vim.list_contains({ "terraform", "terraform-vars", "hcl" }, vim.bo[bufnr].filetype) and 5000 or 500
    return { timeout_ms = timeout, lsp_fallback = true }
  end,
}

return options
