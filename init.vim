let HOMEBREW_PREFIX = system('brew --prefix')
let FZF_DIR = HOMEBREW_PREFIX . '/bin/fzf'
set rtp+=FZF_DIR

call plug#begin('~/.local/share/nvim/plugged')

Plug 'ap/vim-buftabline'
Plug 'FooSoft/vim-argwrap'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'dhruvasagar/vim-table-mode'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'jiangmiao/auto-pairs'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'leafgarland/typescript-vim'
Plug 'lepture/vim-jinja'
Plug 'machakann/vim-highlightedyank'
Plug 'majutsushi/tagbar'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mileszs/ack.vim'
Plug 'mitsuhiko/jinja2'
Plug 'neomake/neomake'
Plug 'pangloss/vim-javascript'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'peitalin/vim-jsx-typescript'
Plug 'preservim/vim-markdown'
Plug 'qpkorr/vim-bufkill'
Plug 'rhysd/committia.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'shaunsingh/nord.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'tmhedberg/SimpylFold'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'vim-scripts/cscope.vim'
Plug 'vim-scripts/surround.vim'
Plug 'vim-scripts/unimpaired.vim'
Plug 'yuezk/vim-js'
Plug 'zchee/deoplete-jedi'

call plug#end()


" -----------------------------------------------------------------------------
" General
" -----------------------------------------------------------------------------

colorscheme nord

inoremap <c-c> <ESC>

set nofoldenable
set nofixendofline
set completeopt=noinsert,menuone,noselect
set cmdheight=2
set breakindent
set nohls

syntax on
filetype on
filetype plugin on

" Close preview window automatically
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Smart 'sudo' save - w!! to prompt for sudo password
:cmap w!! w !sudo tee % >/dev/null

" Disable the splash screen
set shortmess +=I

" Set <Leader> to ','
let mapleader = ","

" Toggle 'paste' with <Leader>p
set pastetoggle=<Leader>p

" Toggle line wrapping
nnoremap <Leader>wr :set wrap! wrap?<CR>

" Try to intelligently indent
set smartindent

"Use spaces for tabs
set expandtab

" A tab character is two spaces
set tabstop=2
set shiftwidth=2

" When inserting a bracket, briefly jump to matchine one
set showmatch

" Don't wrap at window boundary
set nowrap
set linebreak

" Use UTF-8 encoding for Vim
set encoding=utf-8

" Set UTF-8 encoding for file/buffer
set fileencoding=utf-8

" Using a dark background
set background=dark

" Make :e use bash-style tab completion
set wildmode=longest,list,full
set wildmenu

" Turn on line numbering
set number
set relativenumber

" Don't require saving buffer to open another buffer
set hidden

" Set characters to use when displaying non-printing characters
set listchars=tab:→\ ,trail:·,precedes:«,extends:»,eol:¶

set notagrelative
set tags^=.git/tags,*/.git/tags;~
set tagcase=smart

" Show command in last line
set noshowcmd

" Show mode in last line
set showmode
"
" Be smarter when working with tabs
set smarttab
"
" Make case-insensitive search the norm
set ignorecase

" Override case insensitive search
set smartcase
set complete-=i

" Toggle line numbering
nmap <Leader><C-N> :set invnumber<CR>

" Toggle display of non-printing characters
nnoremap <Leader>li :set list! list?<CR>

nnoremap <leader>] :bnext<CR>
nnoremap <leader>[ :bprev<CR>

" Show the line and column number in the statusbar
set ruler
set laststatus=2
set statusline=%F%m%r%h%w\ [type=%Y]\ [%p%%]\ [len=%L]\ [POS=%04l,%04v]\

" Use spell check with commits
autocmd FileType gitcommit setlocal spell

" Enable Tmux copy/paste
set clipboard=unnamed
if $TMUX == ''
    set clipboard+=unnamed
endif

if &diff
  set diffopt-=internal
  set diffopt+=iwhite
endif
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" deoplete
" -----------------------------------------------------------------------------

let g:python3_host_prog = resolve(expand($VIM_PY_PATH))
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('deoplete-options-yarp', v:true)
call deoplete#custom#option('omni_patterns', {
\ 'go': '[^. *\t]\.\w*',
\})


" -----------------------------------------------------------------------------
" echodoc
" -----------------------------------------------------------------------------

let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'virtual'
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" neoformat
" -----------------------------------------------------------------------------

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to space conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
" -----------------------------------------------------------------------------


" -----------------------------------------------------------------------------
" neomake
" -----------------------------------------------------------------------------

" Syntax checking
let g:neomake_python_enabled_makers = ['pylint']
" -----------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" The-NERD-Commenter
" ------------------------------------------------------------------------------

let NERDSpaceDelims=1
" ------------------------------------------------------------------------------


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
" ------------------------------------------------------------------------------


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
set incsearch

" Highlight the current line.
autocmd BufEnter * setlocal cursorline
autocmd BufWinLeave * setlocal nocursorline

" Decrease timeout, e.g. <shift>+O
set timeout timeoutlen=5000 ttimeoutlen=100

" Use fancy Powerline symbols
let g:Powerline_symbols = 'fancy'

" Visual Bell
set vb
" ------------------------------------------------------------------------------


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


" ------------------------------------------------------------------------------
" Movement & Editing Config
" ------------------------------------------------------------------------------

" Bubble single lines
nmap <Leader><Up> [e
nmap <Leader><Down> ]e

" Bubble multiple lines
vmap <Leader><Up> [egv
vmap <Leader><Down> ]egv

" Remove whitespace. 
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr> 
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" ultisnips
" ------------------------------------------------------------------------------

let g:UltiSnipsExpandTrigger='<tab>'

" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'

" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" gist-vim
" ------------------------------------------------------------------------------
"
" Post a private Gist with <leader>g
map <leader>g :Gist -p<cr>
nmap <leader>gs :Gstatus<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gg :Gbrowse<cr>
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" FZF Config
" ------------------------------------------------------------------------------
noremap <expr> <Leader><Leader> (len(system('git rev-parse')) ? ':FZF' : ':GFiles --cached --others --exclude-standard')."\<cr>"
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Ack Config
" ------------------------------------------------------------------------------

nnoremap <leader>a :Ack!<space>
if executable("rg")
  let g:ackprg="rg --vimgrep --smart-case"
  let g:ack_use_cword_for_empty_search = 1
  cnoreabbrev Ack Ack!
endif
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" vim-argwrap
" ------------------------------------------------------------------------------

nnoremap <silent> <leader>j :ArgWrap<CR>
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" Tabularize Config
" ------------------------------------------------------------------------------
if exists(":Tabularize")
  nmap <Leader>k= :Tabularize /^[^=]*\zs=/<CR>
  nmap <Leader>k: :Tabularize /:\zs<CR>
endif
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" NERDTree Config
" ------------------------------------------------------------------------------

nnoremap <silent> <leader>/ <ESC>:NERDTreeToggle<RETURN>
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" TagBar Config
" ------------------------------------------------------------------------------
nnoremap <silent> <leader>. :TagbarToggle<CR>  
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" vim-table-mode
" ------------------------------------------------------------------------------

let g:table_mode_corner="|"
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" ale
" ------------------------------------------------------------------------------

if $PIPENV_ACTIVE == "1"
  let $MYPYPATH = $VIRTUAL_ENV . "/lib/python3.7/site-packages/"
endif
let g:ale_python_pylint_change_directory = 0
let g:ale_python_flake8_change_directory = 0
let g:ale_python_auto_pipenv = 1
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" easy-align
" ------------------------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" ------------------------------------------------------------------------------


" ------------------------------------------------------------------------------
" cscope Config
" ------------------------------------------------------------------------------

if has("cscope")
  set nocscopetag
  set cscopequickfix=s-,c-,d-,i-,t-,e-
  set nocscopeverbose

  if filereadable(".git/cscope.out")
    cscope add .git/cscope.out
  endif
  set cscopeverbose

  nnoremap <Leader>fs :cscope find s <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR>
  nnoremap <Leader>fg :cscope find g <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR>
  nnoremap <Leader>fc :cscope find c <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR>
  nnoremap <Leader>ft :cscope find t <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR>
  nnoremap <Leader>fe :cscope find e <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR>
  nnoremap <Leader>ff :cscope find f <C-R>=expand("<cfile>")<CR><CR>:botright cwindow<CR>
  nnoremap <Leader>fd :cscope find d <C-R>=expand("<cword>")<CR><CR>:botright cwindow<CR>
  nnoremap <Leader>fi :cscope find i ^<C-R>=expand("<cfile>")<CR>$<CR>:botright cwindow<CR>

  "TODO: figure out how to get cstag output in quickfix or a popup menu.
  map <C-_> :cstag <C-R>=expand("<cword>")<CR><CR>

  function! CscopeRebuild()
    cscope kill .git/cscope.out
    silent execute "!./.git/hooks/cscope"
    if v:shell_error
      redraw!
      echohl ErrorMsg | echo "Unable to run cscope command." | echohl None
    else
      if filereadable(".git/cscope.out")
        redraw!
        cscope add .git/cscope.out
      else
        redraw!
        echohl ErrorMsg | echo "Unable to read cscope database." | echohl None
      endif
    endif
  endfunction

  command! Cscope call CscopeRebuild()
endif
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" go
" ------------------------------------------------------------------------------

let g:go_highlight_structs = 0
let g:go_highlight_interfaces = 0
let g:go_highlight_operators = 0

let g:go_fmt_fail_silently = 1
let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }

let g:go_test_show_name = 1
let g:go_list_type = "quickfix"

let g:go_autodetect_gopath = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']
let g:go_metalinter_enabled = ['vet', 'golint']

let g:go_gopls_complete_unimported = 1

" 2 is for errors and warnings
let g:go_diagnostics_level = 2
let g:go_doc_popup_window = 1

let g:go_imports_mode="gopls"
let g:go_imports_autosave=1

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1

let g:go_fold_enable = []
if executable('asdf')
  let g:asdf_go_path = trim(system('asdf where golang'))
  let g:go_bin_path = g:asdf_go_path . "/go/bin"
endif
" ------------------------------------------------------------------------------

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap
augroup END

let g:vim_jsx_pretty_colorful_config = 1 "
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
