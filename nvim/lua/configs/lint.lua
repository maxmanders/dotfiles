local lint = require "lint"

lint.linters_by_ft = {
  python = { "ruff" },
  yaml = { "yamllint" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
}

lint.linters.yamllint = vim.tbl_extend("force", lint.linters.yamllint, {
  args = function()
    if vim.fn.expand "%:t" == "Chart.yaml" then
      return { "-d", "{extends: default, rules: {line-length: disable, empty-lines: {max-end: false}}}", "--format", "parsable", "-" }
    end
    return { "--format", "parsable", "-" }
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
