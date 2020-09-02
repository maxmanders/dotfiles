" ------------------------------------------------------------------------------
" Vundle Config
" ------------------------------------------------------------------------------
"
set nocompatible
set rtp+=/usr/local/opt/fzf
call plug#begin('~/.vim/plugged')
Plug 'OmniSharp/omnisharp-vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'
Plug 'chr4/nginx.vim'
Plug 'davidhalter/jedi-vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'frimik/ultisnips-terraform-snippets'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-consul'
Plug 'hashivim/vim-nomadproject'
Plug 'hashivim/vim-packer'
Plug 'hashivim/vim-terraform'
Plug 'hashivim/vim-vaultproject'
Plug 'hdiniz/vim-gradle'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'lepture/vim-jinja'
Plug 'majutsushi/tagbar'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mileszs/ack.vim'
Plug 'mitsuhiko/vim-rst'
Plug 'mitsuhiko/jinja2'
Plug 'plasticboy/vim-markdown'
Plug 'qpkorr/vim-bufkill'
Plug 'rbong/vim-flog'
Plug 'rodjek/vim-puppet'
Plug 'rhysd/committia.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'vim-scripts/surround.vim'
Plug 'vim-scripts/unimpaired.vim'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-tagprefix'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/ncm2-rst-subscope'

call plug#end()


" ------------------------------------------------------------------------------
" Startup & General Config
" ------------------------------------------------------------------------------
colorscheme nord

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

set notagrelative
set tags^=.git/tags,*/.git/tags;~
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
" FZF Config
" ------------------------------------------------------------------------------
"map <Leader><Leader> :FZF<cr>
"map <Leader><Leader> :GFiles<cr>
nnoremap <expr> <Leader><Leader> (len(system('git rev-parse')) ? ':FZF' : ':GFiles')."\<cr>"



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
  nmap <Leader>k= :Tabularize /^[^=]*\zs=/<CR>
  nmap <Leader>k: :Tabularize /:\zs<CR>
endif


" ------------------------------------------------------------------------------
" NERDTree Config
" ------------------------------------------------------------------------------
" Open NERDTree on Vim launch
" let g:nerdtree_tabs_open_on_console_startup = 1
" autocmd BufWinEnter * :NERDTreeTabsOpen
" autocmd BufWinEnter * :NERDTreeMirrorOpen
" autocmd VimEnter * wincmd w
nnoremap <silent> <leader>/ <ESC>:NERDTreeToggle<RETURN>


" ------------------------------------------------------------------------------
" Airline Config
" ------------------------------------------------------------------------------
set t_Co=256
let g:airline_powerline_fonts = 1
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
" HCL
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.hcl set syntax=terraform
au BufNewFile,BufRead *.hcl set filetype=terraform

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

let g:terraform_fmt_on_save=1

set diffopt+=iwhite

let g:ale_python_pylint_change_directory = 0
let g:ale_python_flake8_change_directory = 0
let g:ale_python_auto_pipenv = 1
" let g:ale_python_pylint_options = "--init-hook='import sys; sys.path.append(\".\")'"
if $PIPENV_ACTIVE == "1"
  let $MYPYPATH = $VIRTUAL_ENV . "/lib/python3.7/site-packages/"
endif


let g:LanguageClient_autoStart = 1
" Use the location list instead of the quickfix list to show linter warnings
let g:LanguageClient_diagnosticsList = "Location"
let g:LanguageClient_rootMarkers = {
    \ 'java': ['.git'],
    \ 'javascript': ['.git'],
    \ 'python': ['.git'],
    \ 'puppet': ['.git'],
    \ 'yaml': ['.git']
    \ }
let g:LanguageClient_serverCommands = {
    \ 'java': ['java-lsp'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'python': ['pyls'],
    \ 'yaml': ['yaml-language-server', '--stdio']
    \ }


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set nofixendofline
