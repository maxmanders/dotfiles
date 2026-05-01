require("nvchad.configs.lspconfig").defaults()

local servers = {
  "bashls",
  "clangd",
  "cssls",
  "gopls",
  "helm-ls",
  "html",
  "pyright",
  "ruff",
  "terraformls",
  "ts_ls",
  "yaml-language-server",
}
vim.lsp.config("yaml-language-server", {
  settings = {
    yaml = {
      schemas = {
        -- ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json"] = ["/*.yaml","/*.yml"],
        ["kubernetes"] = "/*.yaml",
        ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
      },
    },
  },
})

vim.lsp.config("helm-ls", {
  settings = {
    helm_ls = {
      yamlls = {
        path = "yaml-language-server",
      },
    },
  },
})


vim.lsp.enable(servers)

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
    -- Restore gq to use Vim's built-in line-wrapper instead of LSP
    vim.bo[args.buf].formatexpr = ""
  end,
})

-- read :h vim.lsp.config for changing options of lsp servers
