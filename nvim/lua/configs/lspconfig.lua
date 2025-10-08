require("nvchad.configs.lspconfig").defaults()

local servers = { "bashls", "html", "cssls", "ts_ls", "terraformls", "clangd", "pyre", "pyright", "gopls" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
