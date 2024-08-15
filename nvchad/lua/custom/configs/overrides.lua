local M = {}

M.treesitter = {
  ensure_installed = {
    "c",
    "css",
    "go",
    "html",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "tsx",
    "typescript",
    "vim",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- golang
    "gopls",

    -- python
    "pyre",
    "pyright",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.telescope = {
  file_ignore_patterns = {
    "node_modules"
  },
  pickers = {
    find_files = {
      follow = true
    }
  },
}

return M
