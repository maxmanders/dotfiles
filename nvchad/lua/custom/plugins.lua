local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = overrides.telescope
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    lazy = false,
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    'stevearc/aerial.nvim',
    lazy = false,
    opts = {},
    config = function()
      require("aerial").setup({
        float = {
          relative = "win",
          override = function(conf)
            local padding = 1
            conf.anchor = 'NE'
            conf.row = padding
            conf.col = vim.api.nvim_win_get_width(0) - padding
            return conf
          end,
        },
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
    end,
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },

  {
    "ludovicchabant/vim-gutentags",
    lazy = false,
  },

  {
    "airblade/vim-gitgutter",
    lazy = false,
  },

  {
    "airblade/vim-rooter",
    lazy = false,
  },

  {
    "dhruvasagar/vim-table-mode",
    lazy = false,
  },

  {
    "sheerun/vim-polyglot",
    lazy = false,
  },

  {
    "rhysd/committia.vim",
    ft = "gitcommit",
    config = function()
      vim.g.committia_min_window_width = 140
      vim.g.committia_edit_window_width = 90
    end,
  },

  {
    "tpope/vim-fugitive",
    event = "VeryLazy"
  },

  {
    "tpope/vim-rhubarb",
    lazy = false,
  },

  {
    "mattn/vim-gist",
    lazy = false,
    dependencies = {
      "mattn/webapi-vim"
    },
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
