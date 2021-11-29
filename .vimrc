" Vundle Config
" ------------------------------------------------------------------------------
"
set rtp+=/usr/local/opt/fzf
set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'arcticicestudio/nord-vim'
Plug 'davidhalter/jedi-vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'dense-analysis/ale'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'lepture/vim-jinja'
Plug 'majutsushi/tagbar'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'mileszs/ack.vim'
Plug 'mitsuhiko/jinja2'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'peitalin/vim-jsx-typescript'
Plug 'plasticboy/vim-markdown'
Plug 'qpkorr/vim-bufkill'
Plug 'rbong/vim-flog'
Plug 'rodjek/vim-puppet'
Plug 'rhysd/committia.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/The-NERD-Commenter'
Plug 'vim-scripts/surround.vim'
Plug 'vim-scripts/unimpaired.vim'
Plug 'vim-scripts/cscope.vim'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'Yggdroot/indentLine'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
Plug 'ObserverOfTime/ncm2-jc2', {'for': ['java', 'jsp']}
Plug 'artur-shaik/vim-javacomplete2', {'for': ['java', 'jsp']}
Plug 'ncm2/ncm2-tagprefix'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/ncm2-rst-subscope'
Plug 'Shougo/echodoc.vim'

let g:ncm2#matcher = {
  \ 'name': 'combine',
  \ 'matchers': ['abbrfuzzy', 'substr']
\ }

call plug#end()

let g:python3_host_prog = resolve(expand($VIM_PY_PATH))

autocmd BufEnter * call ncm2#enable_for_buffer()
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('deoplete-options-yarp', v:true)

set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'

set completeopt=noinsert,menuone,noselect
inoremap <c-c> <ESC>
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Press enter key to trigger snippet expansion
" The parameters are the same as `:help feedkeys()`
" inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

" c-j c-k for moving in snippet
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets = "<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-k>"
" let g:UltiSnipsRemoveSelectModeMappings = 0
" let g:UltiSnipsSnippetDirectories=["UltiSnips", $HOME . "/.vim/plugged/aws-vim/snips/"]


" ------------------------------------------------------------------------------
" Startup & General Config
" ------------------------------------------------------------------------------
colorscheme nord

set nofoldenable
set nofixendofline

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
let g:NERDDefaultAlign = 'left'

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
noremap <expr> <Leader><Leader> (len(system('git rev-parse')) ? ':FZF' : ':GFiles --cached --others --exclude-standard')."\<cr>"



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
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" ------------------------------------------------------------------------------
" JavaScript
" ------------------------------------------------------------------------------
autocmd FileType javascript set tabstop=2
autocmd FileType javascript set shiftwidth=2
autocmd FileType javascript set expandtab
autocmd FileType javascript set smartindent

" ------------------------------------------------------------------------------
" HCL
" ------------------------------------------------------------------------------
au BufNewFile,BufRead *.hcl set syntax=hcl
au BufNewFile,BufRead *.hcl set filetype=hcl
au BufNewFile,BufRead *.nomad set syntax=hcl
au BufNewFile,BufRead *.nomad set filetype=hcl

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

if &diff
  set diffopt-=internal
  set diffopt+=iwhite
endif

let g:ale_python_pylint_change_directory = 0
let g:ale_python_flake8_change_directory = 0
let g:ale_python_auto_pipenv = 1
let g:ale_java_javac_executable = "javac -cp " . $HOME . "/lombok.jar"
" let g:ale_python_pylint_options = "--init-hook='import sys; sys.path.append(\".\")'"
if $PIPENV_ACTIVE == "1"
  let $MYPYPATH = $VIRTUAL_ENV . "/lib/python3.7/site-packages/"
endif


let g:LanguageClient_autoStart = 1
" Use the location list instead of the quickfix list to show linter warnings
let g:LanguageClient_diagnosticsList = "Location"
let g:LanguageClient_rootMarkers = {
    \ 'go': ['.go'],
    \ 'java': ['.git'],
    \ 'typescript': ['.git'],
    \ 'javascript': ['.git'],
    \ 'javascript.jsx': ['.git'],
    \ 'python': ['.git'],
    \ 'puppet': ['.git'],
    \ 'terraform': ['.git'],
    \ }
let g:LanguageClient_serverCommands = {
    \ 'go': ['gopls'],
    \ 'java': [$HOME . '/code/src/github.com/max@maxmanders.co.uk/java-language-server/dist/lang_server_mac.sh'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ 'javascript': ['typescript-language-server', '--stdio'],
    \ 'javascript.jsx': ['typescript-language-server', '--stdio'],
    \ 'python': ['pyls'],
    \ 'puppet': ['puppet-lsp'],
    \ 'terraform': ['terraform-ls', 'serve'],
    \ }

nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_completion()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ------------------------------------------------------------------------------
" cscope Config
" ------------------------------------------------------------------------------
"
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

let g:indentLine_char = '⦙'
let g:indentLine_setColors = 0
let g:indentLine_defaultGroup = 'SpecialKey'
