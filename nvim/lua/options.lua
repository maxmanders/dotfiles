require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
vim.wo.relativenumber = true
vim.opt.hls = false
vim.opt.mouse = ""

vim.o.foldenable = false

-- autoformat Go files on save
local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "just",
  callback = function()
    vim.bo.commentstring = "# %s"
  end
})

-- Create an autocommand for "BufRead" events
vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*.yaml.gotmpl", "*.gotmpl" },
  callback = function()
    vim.opt.filetype = "yaml"
  end
})

require('nvim-tree').setup {
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')

    -- Important: When you supply an `on_attach` function, nvim-tree won't
    -- automatically set up the default keymaps. To set up the default keymaps,
    -- call the `default_on_attach` function. See `:help nvim-tree-quickstart-custom-mappings`.
    api.config.mappings.default_on_attach(bufnr)

    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local preview = require('nvim-tree-preview')

    vim.keymap.set('n', 'P', preview.watch, opts 'Preview (Watch)')
    vim.keymap.set('n', '<Esc>', preview.unwatch, opts 'Close Preview/Unwatch')
    vim.keymap.set('n', '<C-f>', function() return preview.scroll(4) end, opts 'Scroll Down')
    vim.keymap.set('n', '<C-b>', function() return preview.scroll(-4) end, opts 'Scroll Up')

    -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
    vim.keymap.set('n', '<Tab>', function()
      local ok, node = pcall(api.tree.get_node_under_cursor)
      if ok and node then
        if node.type == 'directory' then
          api.node.open.edit()
        else
          preview.node(node, { toggle_focus = true })
        end
      end
    end, opts 'Preview')

    -- Option B: Simple tab behavior: Always preview
    -- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
  end,
}

local api = require("nvim-tree.api")

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if (vim.fn.bufname() == "NvimTree_1") then return end

        api.tree.find_file({ buf = vim.fn.bufnr() })
    end,
})
