" if (system('uname') =~ "Darwin")
  " let g:python_host_prog='/Users/max/dev/vimrc/venv/bin/python'
  " let g:python3_host_prog='/Users/max/dev/vimrc/venv/bin/python'
" endif
" ------------------------------------------------------------------------------
" Vundle Config
" ------------------------------------------------------------------------------
"
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf
call vundle#begin()
Plugin 'FooSoft/vim-argwrap'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'b4b4r07/vim-hcl'
Plugin 'benmills/vimux'
Plugin 'c9s/vikube.vim.git'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dhruvasagar/vim-table-mode.git'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'edkolev/promptline.vim'
Plugin 'ekalinin/Dockerfile.vim'
Bundle 'ervandew/supertab'
Plugin 'garbas/vim-snipmate'
Plugin 'godlygeek/tabular'
Plugin 'honza/vim-snippets'
Plugin 'hashivim/vim-consul'
Plugin 'hashivim/vim-nomadproject'
Plugin 'hashivim/vim-packer'
Plugin 'hashivim/vim-terraform'
Plugin 'hashivim/vim-vaultproject'
Plugin 'ingydotnet/yaml-vim'
Plugin 'jamessan/vim-gnupg.git'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'jlanzarotta/bufexplorer.git'
Plugin 'junegunn/fzf.git'
Plugin 'junegunn/goyo.vim'
Plugin 'jwhitley/vim-matchit.git'
Plugin 'lepture/vim-jinja'
Plugin 'leshill/vim-json'
Plugin 'majutsushi/tagbar'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'mileszs/ack.vim.git'
Plugin 'mitsuhiko/vim-rst.git'
Plugin 'plasticboy/vim-markdown'
Plugin 'qpkorr/vim-bufkill'
Plugin 'rodjek/vim-puppet.git', {'name': 'vim-puppet-ctags'}
Plugin 'ryanoasis/vim-devicons'
Plugin 'scrooloose/nerdtree.git'
Plugin 'terryma/vim-expand-region'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'tpope/vim-sleuth'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/The-NERD-Commenter.git'
Plugin 'vim-scripts/surround.vim.git'
Plugin 'vim-scripts/unimpaired.vim.git'
Plugin 'voithos/vim-python-matchit.git'
Plugin 'voxpupuli/vim-puppet.git'
Plugin 'w0rp/ale'

call vundle#end()
filetype plugin indent on


" ------------------------------------------------------------------------------
" Startup & General Config
" ------------------------------------------------------------------------------
" Load Vim Solarized theme
" let g:solarized_termtrans=1
colorscheme solarized

" Vi-compatible - do not want
set nocp

set breakindent

" Enable syntax highlighting
syntax on

" Detect syntax based on filetype
filetype on

" Load plugins based on filetype
filetype plugin on

" Smart 'sudo' save - w!! to prompt for sudo password
:cmap w!! w !sudo tee % >/dev/null

" Disable the splash screen
:set shortmess +=I

" Set <Leader> to ','
let mapleader = ","

" Toggle 'paste' with <Leader>p
set pastetoggle=<Leader>p

" Toggle line wrapping
nnoremap <Leader>wr :set wrap! wrap?<CR>

" Try to intelligently indent
:set smartindent

"Use spaces for tabs
:set expandtab

" A tab character is two spaces
:set tabstop=2
:set shiftwidth=2

" When inserting a bracket, briefly jump to matchine one
:set showmatch

" Don't wrap at window boundary
:set nowrap
:set linebreak

" Use UTF-8 encoding for Vim
:set encoding=utf-8

" Set UTF-8 encoding for file/buffer
:set fileencoding=utf-8

" Using a dark background
:set background=dark

" Make :e use bash-style tab completion
:set wildmode=longest,list,full
:set wildmenu

" Turn on line numbering
:set number
:set relativenumber

" Don't require saving buffer to open another buffer
:set hidden

" Set characters to use when displaying non-printing characters
set listchars=tab:→\ ,trail:·,precedes:«,extends:»,eol:¶

" Where to look by default for tags
set tags=./.git/tags
set tagcase=smart

" Show command in last line
:set noshowcmd

" Show mode in last line
:set showmode
"
" Be smarter when working with tabs
:set smarttab
"
" Make case-insensitive search the norm
:set ignorecase

" Override case insensitive search
:set smartcase
:set complete-=i


" Toggle line numbering
nmap <Leader><C-N> :set invnumber<CR>

" Toggle display of non-printing characters
nnoremap <Leader>li :set list! list?<CR>

" Keep code folds open by default.
:set foldlevelstart=99

" Show the line and column number in the statusbar
:set ruler
set laststatus=2
set statusline=%F%m%r%h%w\ [type=%Y]\ [%p%%]\ [len=%L]\ [POS=%04l,%04v]\

let NERDSpaceDelims=1
autocmd FileType gitcommit setlocal spell


" ------------------------------------------------------------------------------
" Swap & Backup Config
" ------------------------------------------------------------------------------
" Don't retain file backups
set nobackup

if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

" Don't retain swap files
set noswapfile

" Reload a buffer if it changes on disk
set autoread

" Enable Tmux copy/paste
set clipboard=unnamed
if $TMUX == ''
    set clipboard+=unnamed
endif


" ------------------------------------------------------------------------------
" Search & Highlighting
" ------------------------------------------------------------------------------
" Highlight under cursor - case sensitive, partial match inclusive
nnoremap <Leader>hi :set hlsearch<CR>:let @/='<C-r><C-w>'<CR>

" Highlight under cursor - case sensitive, no partial match
nnoremap <Leader>ho :set hlsearch<CR>:let @/='\<<C-r><C-w>\>'<CR>

" Highlight under cursor - case insensitive, partial match inclusive
nnoremap <Leader>hu :set hlsearch<CR>:let @/='<C-r><C-w>\c'<CR>

" Highlight under cursor - case insensitive, no partial match
nnoremap <Leader>hy :set hlsearch<CR>:let @/='\<<C-r><C-w>\>\c'<CR>

" Incrementally search while typing
:set incsearch

" Highlight the current line.
autocmd BufEnter * setlocal cursorline
autocmd BufWinLeave * setlocal nocursorline

" Decrease timeout, e.g. <shift>+O
set timeout timeoutlen=5000 ttimeoutlen=100

" Use fancy Powerline symbols
let g:Powerline_symbols = 'fancy'

" Visual Bell
set vb

" Edit and Source VimRC
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>


" ------------------------------------------------------------------------------
" Tab Movement Config
" ------------------------------------------------------------------------------
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>t[ :tabp<cr>
map <leader>t] :tabn<cr>
hi TabLine cterm=bold,underline ctermfg=7 ctermbg=0
hi TabLineSel cterm=bold ctermfg=0 ctermbg=7
hi TabLineFill cterm=bold ctermbg=none


" ------------------------------------------------------------------------------
" Movement & Editing Config
" ------------------------------------------------------------------------------
" Bubble single lines
nmap <Leader><Up> [e
nmap <Leader><Down> ]e

" Bubble multiple lines
vmap <Leader><Up> [egv
vmap <Leader><Down> ]egv

" Insert current date
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

" Remove whitespace. 
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr> 

" Post a private Gist with <leader>g
map <leader>g :Gist -p<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gg :Gbrowse<cr>


" ------------------------------------------------------------------------------
" CtrlP Config
" ------------------------------------------------------------------------------
" Set CtrlP Hotkey
" :map <Leader><leader> :CtrlP<CR>
" :map <Leader>. :CtrlPTag<CR>

" ------------------------------------------------------------------------------
" FZF Config
" ------------------------------------------------------------------------------
map <Leader><Leader> :FZF<cr>


" ------------------------------------------------------------------------------
" Ack/Ag Config
" ------------------------------------------------------------------------------
nnoremap <leader>a :Ack!<space>
if executable("ag")
  let g:ackprg="ag --nogroup --nocolor --column"
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l%c%m
endif


" ------------------------------------------------------------------------------
" ArgWrap Config
" ------------------------------------------------------------------------------
nnoremap <silent> <leader>j :ArgWrap<CR>

" ------------------------------------------------------------------------------
" Tabularize Config
" ------------------------------------------------------------------------------
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=><CR>
  vmap <Leader>a= :Tabularize /=><CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>ac :Tabularize /^\s*\S\+\zs/l0c1l0<CR>
  nmap <Leader>ac :Tabularize /^\s*\S\+\zs/l0c1l0<CR>
endif


" ------------------------------------------------------------------------------
" YCM & UtiliSnips Config
" ------------------------------------------------------------------------------
" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" let g:UltiSnipsSnippetDirectories=["UltiSnips"]

set omnifunc=syntaxcomplete#Complete


" ------------------------------------------------------------------------------
" NERDTree Config
" ------------------------------------------------------------------------------
" Open NERDTree on Vim launch
" let g:nerdtree_tabs_open_on_console_startup = 1
" autocmd BufWinEnter * :NERDTreeTabsOpen
" autocmd BufWinEnter * :NERDTreeMirrorOpen
" autocmd VimEnter * wincmd w
" F2: Toggle NERDTree
nmap <F2> <ESC>:NERDTreeToggle<RETURN>


" ------------------------------------------------------------------------------
" Airline Config
" ------------------------------------------------------------------------------
set t_Co=256
let g:airline_powerline_fonts = 1
" let g:airline_solarized_bg='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_inactive_collapse = 0
let g:virtualenv_auto_activate = 1
set laststatus=2


" ------------------------------------------------------------------------------
" TagBar Config
" ------------------------------------------------------------------------------
nnoremap <silent> <leader>. :TagbarToggle<CR>  
nnoremap <silent> <leader>/ :CtrlPTag<cr>  

let g:tagbar_type_terraform = {  
    \ 'ctagstype' : 'terraform',
    \ 'kinds' : [
    \ 'r:resources',
    \ 'm:modules',
    \ 'o:outputs',
    \ 'v:variables',
    \ 'f:tfvars'
    \ ],
    \ 'sort' : 0
    \ }


" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" LiveDown Config
" ------------------------------------------------------------------------------
nmap gm :LivedownPreview<CR>
"


" ------------------------------------------------------------------------------
" YAML
" ------------------------------------------------------------------------------
" A tab character is two spaces
:autocmd FileType yaml set tabstop=2
" Authoindent is two spaces (one tab)
:autocmd FileType yaml set shiftwidth=2

" ------------------------------------------------------------------------------
" JavaScript
" ------------------------------------------------------------------------------
:autocmd FileType javascript set tabstop=2
:autocmd FileType javascript set shiftwidth=2
:autocmd FileType javascript set expandtab
:autocmd FileType javascript set smartindent

" ------------------------------------------------------------------------------
" Markdown
" ------------------------------------------------------------------------------
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.markdown set filetype=markdown
autocmd BufNewFile,BufReadPost *.mkd set filetype=markdown

au FileType markdown highlight htmlBold gui=bold guifg=#af0000 ctermfg=124
au FileType markdown highlight htmlItalic gui=italic guifg=#ff8700 ctermfg=214
au FileType markdown set conceallevel=0
" Length of line is 120 characters
au FileType markdown set tw=120
" Add a vertical column at 120 characters
au FileType markdown set cc=120
" Automatically wrap text
au FileType markdown set wrap
au FileType markdown set fo+=t

" ------------------------------------------------------------------------------
" JSON
" ------------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd FileType json noremap <C-L> :!jsonlint %<CR>
autocmd FileType json set foldmethod=syntax
autocmd FileType json set foldnestmax=10
autocmd FileType json set nofoldenable
autocmd FileType json set foldlevel=1
autocmd FileType json let g:vim_json_syntax_conceal = 0

" ------------------------------------------------------------------------------
" Puppet
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.pp set syntax=puppet
au BufNewFile,BufRead *.pp setlocal tabstop=2
au BufNewFile,BufRead *.pp setlocal shiftwidth=2
au BufNewFile,BufRead *.pp setlocal expandtab
au BufNewFile,BufRead *.pp set cc=80
" Comment out code with '# <code>'
au FileType puppet let &commentstring="#  %s"
" Make ctags work with top-scope and modules
au FileType puppet setlocal isk+=:
au FileType puppet nnoremap <c-]> :exe "tag " . substitute(expand("<cword>"), "^::", "", "")<CR>
au FileType puppet nnoremap <c-w><c-]> :tab split<CR>:exe "tag " . substitute(expand("<cword>"), "^::", "", "")<CR>
let g:tagbar_type_puppet = {
    \ 'ctagstype': 'puppet',
    \ 'kinds': [
        \'c:class',
        \'s:site',
        \'n:node',
        \'d:definition'
      \]
    \}
let g:airline#extensions#tagbar#enabled = 0

" ------------------------------------------------------------------------------
" PHP
" ------------------------------------------------------------------------------
:let php_sql_query=1
:let php_htmlInStrings=1
:let php_folding=1
:let php_parent_error_close=1
:let php_parent_error_open=1
" PHP parser check (CTRL-L)
:autocmd FileType php noremap <C-L> :!php -l %<CR>
" run file with PHP CLI (CTRL-M)
:autocmd FileType php noremap <C-M> :w!<CR>:!php %<CR>
" Use ctrl-k to check PHP docs, first
" sudo pear install doc.php.net/pman
:autocmd FileType php set keywordprg=/usr/bin/pman
" A tab character is two spaces
:autocmd FileType php set tabstop=2
" Authoindent is two spaces (one tab)
:autocmd FileType php set shiftwidth=2
" Margin
:autocmd FileType php set cc=120
" Other PHP file types
:autocmd BufNewFile,BufRead *.inc set ft=php
:autocmd BufNewFile,BufRead *.phpt set ft=php
:autocmd BufNewFile,BufRead *.phtml set ft=php
:autocmd BufNewFile,BufRead *.phps set ft=php

" ------------------------------------------------------------------------------
" Python
" ------------------------------------------------------------------------------
:autocmd Filetype python setlocal tabstop=4
:autocmd Filetype python setlocal shiftwidth=4


" ------------------------------------------------------------------------------
" Ruby
" ------------------------------------------------------------------------------
:autocmd Filetype ruby setlocal tabstop=2
:autocmd Filetype ruby setlocal shiftwidth=2
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }


" ------------------------------------------------------------------------------
" ERB
" ------------------------------------------------------------------------------
:autocmd Filetype eruby setlocal tabstop=2
:autocmd Filetype eruby setlocal shiftwidth=2

" ------------------------------------------------------------------------------
" CSS
" ------------------------------------------------------------------------------
:autocmd Filetype css setlocal tabstop=2
:autocmd Filetype css setlocal shiftwidth=2
:autocmd Filetype scss setlocal tabstop=2
:autocmd Filetype scss setlocal shiftwidth=2


" ------------------------------------------------------------------------------
" Perl
" ------------------------------------------------------------------------------
:autocmd Filetype perl setlocal tabstop=2
:autocmd Filetype perl setlocal shiftwidth=2

" ------------------------------------------------------------------------------
" vim-table-mode
" ------------------------------------------------------------------------------
let g:table_mode_corner="|"

" ------------------------------------------------------------------------------
" vimux
" ------------------------------------------------------------------------------
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vi :VimuxInspectRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'

let g:terraform_fmt_on_save=1
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

:set diffopt+=iwhite