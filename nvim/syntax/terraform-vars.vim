" Syntax stub for terraform-vars (.tfvars) files.
" Actual highlighting is handled by nvim-treesitter.
" This file exists so that vim.fn.getcompletion('', 'filetype') recognises
" 'terraform-vars' as a valid filetype, silencing the checkhealth lsp warning.
if exists('b:current_syntax')
  finish
endif
let b:current_syntax = 'terraform-vars'
