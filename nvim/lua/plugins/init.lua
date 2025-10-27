return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    -- Install markdown preview, use npx if available.
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      if vim.fn.executable "npx" then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd [[Lazy load markdown-preview.nvim]]
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      if vim.fn.executable "npx" then vim.g.mkdp_filetypes = { "markdown" } end
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

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

  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Mapping tab is already used by NvChad
      vim.g.copilot_no_tab_map = true;
      vim.g.copilot_assume_mapped = true;
      vim.g.copilot_tab_fallback = "";
      -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
    end
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    lazy = false,
    config = function()
      require('render-markdown').setup({})
    end,
  },
  {
    "andrewferrier/wrapping.nvim",
    lazy = false,
    config = function()
      require("wrapping").setup()
    end
  },
  {
    "hashivim/vim-terraform",
    init = function()
      vim.api.nvim_create_autocmd({'BufWritePre'}, {
        pattern = '*.tf',
        command = "TerraformFmt"
      })
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "junegunn/vim-easy-align",
    event = "VeryLazy",
  },
  {
    "meznaric/key-analyzer.nvim",
    opts = {},
    lazy = false,
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      "kevinhwang91/promise-async",
    },
    config = function()
      require('ufo').setup()
    end,
    event = "VeryLazy",
  },
  {
    "qvalentin/helm-ls.nvim",
    ft = "helm"
  },
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      {
        'b0o/nvim-tree-preview.lua',
        dependencies = {
          'nvim-lua/plenary.nvim',
          '3rd/image.nvim', -- Optional, for previewing images
        },
      },
    },
  },
}
