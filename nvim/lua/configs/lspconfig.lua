require("nvchad.configs.lspconfig").defaults()

local servers = {
  "bashls",
  "clangd",
  "cssls",
  "gopls",
  "helm-ls",
  "html",
  "pyright",
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
      yalmls = {
        path = "yaml-language-server",
      },
    },
  },
})

vim.lsp.enable(servers)


-- read :h vim.lsp.config for changing options of lsp servers 
