
" No-no-no’s
set nobackup        " do not keep a backup files at all
set noswapfile      " no recovery *.swp files
set nofoldenable    " no folding
set notimeout       " wait for ambigous key in key map forever
set nowrap          " no word wrap

" Tab settings
set expandtab       " expand tabs to spaces
set shiftwidth=4
set softtabstop=4
set tabstop=8

set scrolloff=5     " keep at minimum few lines from top and bottom when scrolling
set hidden          " allow moving around and leaving dirty files
set linebreak       " break on word boundaries if word wrap enabled
set listchars=eol:$,tab:–→,trail:~,extends:>,precedes:<,nbsp:•

" Ignored listing patterns
set wildignore+=*.o,*.pyc,*.orig,.hg,.git,.svn,*.jpg,*.png

" Language settings
set keymap=russian-jcukenwin    " переключение на русский по Ctrl+^
set iminsert=0                  " по умолчанию -- английский для ввода
set imsearch=0                  " по умолчанию -- английский для поиска
set spelllang=ru_yo,en_us       " проверка через словарь с Ё и через английский словарь
highlight lCursor guifg=NONE guibg=Cyan " подсветка курсора при включенном русском

" Auto-reload files when changed outside of the editor
set autoread
autocmd FocusGained * :checktime

" ===========================================================================
" Plugins
" ===========================================================================

" Be explicit about python binaries
let g:python2_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" Automatically install vim-plug on the first run
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" Language support
Plug 'cakebaker/scss-syntax.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'tpope/vim-liquid'

" Python
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

" Editing
Plug 'AndrewRadev/sideways.vim' " swap arguments, arg object
Plug 'junegunn/goyo.vim' " distraction-free writing
Plug 'scrooloose/nerdcommenter' " comment blocks
Plug 'tpope/vim-surround' " surrounding quotes, braces, etc

" UI
Plug 'fholgado/minibufexpl.vim'
Plug 'rakr/vim-one' " color scheme
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Navigation
Plug 'jremmen/vim-ripgrep' " :Rg
Plug 'moll/vim-bbye' " bdelete

Plug '/usr/bin/fzf' " FZF relies on the global fzf tool installation
Plug 'junegunn/fzf.vim'

" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim'

call plug#end()

" ===========================================================================
" Colors
" ===========================================================================

colorscheme one
set background=dark
set termguicolors

" ===========================================================================
" Filetypes
" ===========================================================================

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" Enable custom syntax highlight
augroup filetype
  au! BufRead,BufNewFile *.xod* setfiletype json
  au! BufRead,BufNewFile *.ino setfiletype cpp
  au! BufRead,BufNewFile *.json5 setfiletype javascript
  au! BufRead,BufNewFile *.pde setfiletype cpp
  au! BufRead,BufNewFile *.proto setfiletype proto
  au! BufRead,BufNewFile SCons* setfiletype python
  au! BufRead,BufNewFile *.scons setfiletype python
  au! BufRead,BufNewFile wscript setfiletype python
  au! BufRead,BufNewFile *.less setfiletype less
augroup end

" Custom settings for file types
augroup filetype
  au! FileType javascript set sw=2 sts=2
  au! FileType json set sw=2 sts=2
  au! FileType yaml set sw=2 sts=2
  au! FileType reason set sw=2 sts=2
  au! FileType html set sw=2 sts=2
  au! FileType cpp set sw=4 sts=4
augroup end

" ===========================================================================
" Shortcuts
" ===========================================================================

let mapleader = ","     " remap <leader> to comma

" Remap ex-mode starter to ; as it does not require shift press
" Keep ; still accessible with Alt hold down
nnoremap ; :
nnoremap <m-;> ;
nnoremap <m-,> ,

" Buffer close
nmap <leader>d :Bdelete<cr>

" ,h to clear search highlight
nmap <silent> <leader>/ :nohl<cr>

" F1 to view/edit the personal cheatsheet
nmap <F1> :tabe ~/.dotfiles/vim-cheatsheet.md<CR>

" -------------------------------------
" Clipboard
" -------------------------------------

" ,y copies whole file in <NORMAL> or the selection in <VISUAL> into the system clipboard
nmap <leader>y m'gg"+yG''
vmap <leader>y "+y
" ,p/,P pastes from system clipboard
map <leader>p "+p
map <leader>P "+P

" copy current buffer path into system clipboard
nmap <leader>% :let @+=expand("%")<CR>

" -------------------------------------
" Text navigation
" -------------------------------------

" Home / end alternative
map <c-h> ^
map <c-l> $
" More natural behavior on auto-wrapped lines
nnoremap j gj
nnoremap k gk
" Faster up / down
map <c-j> 3j
map <c-k> 3k

" -------------------------------------
" Line-wise editing
" -------------------------------------

" Map Enter in normal mode to insert blank lines above/bellow cursor. Avoid
" cursor movement with a mark. Apply only if a buffer is modifiable not to
" mess navigation in special windows like FZF or NERDTree.
nnoremap <expr> <CR> &modifiable ? "m'o<ESC>`'" : "\<CR>"
nnoremap <expr> <S-CR> &modifiable ? "m'O\<ESC>`'" : "\<S-CR>"

" Swap the current line with line above/below
nnoremap <silent> ]e :m .+1<CR>==
nnoremap <silent> [e :m .-2<CR>==

" -------------------------------------
" Window/split management
" -------------------------------------

" Ctrl+W+xxx is hard to press. leader W is a faster alternative
nnoremap <leader>w <c-w>

" Quick window navigation
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" Alt with + or - key to resize current window
nnoremap <m-=> <c-w>5+
nnoremap <m--> <c-w>5-

" -------------------------------------
" Language
" -------------------------------------

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> ]r :call LanguageClient#textDocument_rename()<CR>

" -------------------------------------
" Fuzzy find
" -------------------------------------
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fb :Buffers<CR>

" -------------------------------------
" Arguments movement and objects
" -------------------------------------
nnoremap <leader>< :SidewaysLeft<CR>
nnoremap <leader>> :SidewaysRight<CR>
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

" ===========================================================================
" Plugin settings
" ===========================================================================

" Python mode
let g:pymode_python = 'python3'
let g:pymode_rope = 1
let g:pymode_rope_complete_on_dot = 0

" Minibuf explorer
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Vue
let g:vim_vue_plugin_use_sass = 1

" -------------------------------------
" NERDTree
" -------------------------------------

" Shortcut to open immediatelly followed be MiniBufExplorer reopen to keep
" the latter split at the to edge
nmap <silent> <leader>n :NERDTreeToggle <BAR> :MBEOpen!<CR>

let NERDTreeIgnore=['\~$', '\.orig$', '\.pyc$', '\.pyo$', '\.o$', '\.sqlite$', '\.aux$', '\.pdf$', '__pycache__', 'tags']
let NERDTreeMinimalUI=1

" -------------------------------------
" Language server start commands
" -------------------------------------

let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }

" -------------------------------------
" AirLine
" -------------------------------------

let g:airline_theme='one'
let g:airline#extensions#keymap#enabled = '0'
let g:airline_powerline_fonts = 1
" Minimalistic leftmost section: 45%/623  223:46
let g:airline_section_z = '%P/%L  %3l:%-2c'

" -------------------------------------
" FZF
" -------------------------------------

let g:fzf_layout = { 'down': '~20%' }
