return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufEnter", "InsertLeave" },
    config = function()
      require "configs.lint"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    config = function()
      require("nvim-treesitter").setup {
        ensure_installed = { "helm", "python" },
      }
    end,
    init = function()
      _G._safe_ts_foldexpr = function()
        local buf = vim.api.nvim_get_current_buf()
        if not vim.api.nvim_buf_is_valid(buf) then
          return "0"
        end
        local ok, result = pcall(vim.treesitter.foldexpr)
        return ok and result or "0"
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local name = vim.api.nvim_buf_get_name(args.buf)
          local resolved = vim.fn.resolve(name)
          local tmpdir = vim.fn.resolve(vim.env.TMPDIR or "/tmp/")
          if
            vim.startswith(resolved, tmpdir)
            or vim.startswith(resolved, "/private/tmp/")
            or vim.startswith(name, "/tmp/")
          then
            return
          end
          local ok = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua._safe_ts_foldexpr()"
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = {
          enable = true,
          lookahead = true, -- jump to next match if cursor is not inside one
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ay"] = "@block.outer",
            ["iy"] = "@block.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- add to jumplist so <C-o>/<C-i> work
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]k"] = "@class.outer",
            ["]i"] = "@conditional.outer",
            ["]o"] = "@loop.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]K"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[k"] = "@class.outer",
            ["[i"] = "@conditional.outer",
            ["[o"] = "@loop.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[K"] = "@class.outer",
          },
        },
      }
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
    "stevearc/aerial.nvim",
    lazy = false,
    opts = {},
    config = function()
      require("aerial").setup {
        float = {
          relative = "win",
          override = function(conf)
            local padding = 1
            conf.anchor = "NE"
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
      }
    end,
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
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
    "rhysd/committia.vim",
    ft = "gitcommit",
    config = function()
      vim.g.committia_min_window_width = 140
      vim.g.committia_edit_window_width = 90
    end,
  },

  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },

  {
    "tpope/vim-rhubarb",
    lazy = false,
  },

  {
    "mattn/vim-gist",
    lazy = false,
    dependencies = {
      "mattn/webapi-vim",
    },
  },

  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Mapping tab is already used by NvChad
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      -- The mapping is set to other key, see custom/lua/mappings
      -- or run <leader>ch to see copilot mapping section
    end,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    config = function()
      local function is_tmp_buf(buf)
        local name = vim.api.nvim_buf_get_name(buf)
        if name == "" then
          return false
        end
        local resolved = vim.fn.resolve(name)
        local tmpdir = vim.fn.resolve(vim.env.TMPDIR or "/tmp/")
        return vim.startswith(resolved, tmpdir)
          or vim.startswith(resolved, "/private/tmp/")
          or vim.startswith(name, "/tmp/")
      end
      require("render-markdown").setup {
        ignore = is_tmp_buf,
      }
    end,
  },
  {
    "andrewferrier/wrapping.nvim",
    lazy = false,
    config = function()
      require("wrapping").setup()
    end,
  },
  {
    "hashivim/vim-terraform",
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
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
    "qvalentin/helm-ls.nvim",
    ft = "helm",
  },
  {
    "nvim-tree/nvim-tree.lua",
    tag = "v1.15.0",
    dependencies = {
      {
        "b0o/nvim-tree-preview.lua",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "3rd/image.nvim", -- Optional, for previewing images
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        border = true,
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "bottom", -- This is the line you need to add
            mirror_horizontal = true, -- this will exchange prompt and results
          },
        },
        pickers = {
          find_files = {
            theme = "ivy",
          },
        },
      },
    },
    dependencies = {
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        event = "VeryLazy",
        config = function(_, _)
          require("telescope").load_extension "live_grep_args"
        end,
        keys = {
          { "<leader>,", ":Telescope live_grep_args<CR>", desc = "Live Grep" },
        },
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").setup {
            extensions = {
              ["ui-select"] = {
                require("telescope.themes").get_dropdown {},
              },
            },
          }
          require("telescope").load_extension "ui-select"
        end,
      },
    },
  },
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "jfryy/keytrail.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      table.insert(require("keytrail.autocmds").PATTERNS, "*.yaml.gotmpl")
      require("keytrail").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
}
