
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
set showbreak=---⤶  " line break sequence
set breakindent     " keep indent level of soft-wrapped lines
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

if exists('g:GtkGuiLoaded')
  " Using nvim-gtk
  call rpcnotify(1, 'Gui', 'Font', 'Iosevka Regular 12')
  " Enable OpenType features
  call rpcnotify(1, 'Gui', 'FontFeatures', 'PURS, cv17')
endif

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
Plug 'chrisbra/csv.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'leafgarland/typescript-vim'
Plug 'lervag/vimtex'
Plug 'maxmellon/vim-jsx-pretty' " JSX
Plug 'othree/html5.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'rescript-lang/vim-rescript', {'tag': 'v1.4.0'}
Plug 'tpope/vim-liquid'
Plug 'yuezk/vim-js' " JavaScript

" Python
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }

" Editing
Plug 'AndrewRadev/sideways.vim' " swap arguments, arg object
Plug 'bkad/CamelCaseMotion' " camelAndSnake_case_Motions
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
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'  " collection of UltiSnip snippets

call plug#end()

" ===========================================================================
" Colors
" ===========================================================================

colorscheme one
set background=dark
set termguicolors
highlight SignColumn guibg=#2c323c

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
  au! BufRead,BufNewFile *.svelte setfiletype html
  au! BufRead,BufNewFile *.pcss setfiletype css
augroup end

" Custom settings for file types
augroup filetype
  au! FileType javascript set sw=2 sts=2
  au! FileType javascriptreact set sw=2 sts=2
  au! FileType json set sw=2 sts=2
  au! FileType yaml set sw=2 sts=2
  au! FileType reason setlocal sw=2 sts=2 signcolumn=yes
  au! FileType rescript setlocal sw=2 sts=2 signcolumn=yes
  au! FileType html set sw=2 sts=2
  au! FileType cpp set sw=4 sts=4
  au! FileType tex set sw=2 sts=2 wrap
augroup end

" ReScript custom
augroup filetype
  au! FileType rescript nnoremap <silent> <buffer> g= :RescriptFormat<CR>
  au! FileType rescript nnoremap <silent> <buffer> gd :RescriptJumpToDefinition<CR>
  au! FileType rescript set omnifunc=rescript#Complete
augroup end

" ===========================================================================
" Shortcuts
" ===========================================================================

let mapleader = ","       " remap <leader> to comma
let maplocalleader = ","  " same for <localleader> (used by vimtex, e.g.)

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
nnoremap <silent> g= :call LanguageClient#textDocument_formatting()<CR>

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

" InnerCamels
omap <silent> ic <Plug>CamelCaseMotion_iw
xmap <silent> ic <Plug>CamelCaseMotion_iw
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib

" ===========================================================================
" Plugin settings
" ===========================================================================

" -------------------------------------
" Python mode
" -------------------------------------
let g:pymode_python = 'python3'
let g:pymode_rope = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_options_max_line_length = 88 " match Black’s default

" -------------------------------------
" Minibuf explorer
" -------------------------------------
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" -------------------------------------
" Vue
" -------------------------------------
let g:vim_vue_plugin_use_sass = 1

" -------------------------------------
" NERDTree
" -------------------------------------

" Shortcut to open immediatelly followed be MiniBufExplorer reopen to keep
" the latter split at the top edge
nmap <silent> <leader>nn :NERDTreeToggle <BAR> :MBEOpen!<CR>
nmap <silent> <leader>nf :NERDTreeFind<CR>

let NERDTreeIgnore=['\~$', '\.orig$', '\.pyc$', '\.pyo$', '\.o$', '__pycache__', 'tags', '\.bs.js$']
let NERDTreeMinimalUI=1

" -------------------------------------
" LanguageClient
" -------------------------------------

let g:LanguageClient_serverCommands = {
    \ 'reason': ['reason-language-server'],
    \ }

let g:LanguageClient_rootMarkers = {
    \ 'reason': ['bsconfig.json'],
    \ }

let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_useVirtualText = 'No'

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

" -------------------------------------
" Goyo
" -------------------------------------
function! s:goyo_enter()
    set wrap
endfunction

function! s:goyo_leave()
    set nowrap
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" -------------------------------------
" Vimtex
" -------------------------------------
let g:tex_flavor = 'latex'

" Disable insert-mode mappings: ` should stay ё!
let g:vimtex_imaps_enabled = 0

" Disable formatting, mainly because of the 80 char hard-wrap
let g:vimtex_format_enabled = 0

" Do not auto-close on ]] in insert mode, remap to Ctrl+X ]
let g:vimtex_mappings_disable = {
      \ 'i': [ ']]' ],
      \ }

imap <silent><nowait><buffer> <c-x><c-]> <plug>(vimtex-delim-close)

" Some default mappings use <localleader>l as the prefix which conflicts
" with window navigation. Routinelly remap them to <localleader>t. The code
" is taken and adjusted from the vimtex source

nmap <silent><nowait><buffer> <localleader>ti <plug>(vimtex-info)
nmap <silent><nowait><buffer> <localleader>tI <plug>(vimtex-info-full)
nmap <silent><nowait><buffer> <localleader>tx <plug>(vimtex-reload)
nmap <silent><nowait><buffer> <localleader>tX <plug>(vimtex-reload-state)
nmap <silent><nowait><buffer> <localleader>ts <plug>(vimtex-toggle-main)
nmap <silent><nowait><buffer> <localleader>tq <plug>(vimtex-log)

nmap <silent><nowait><buffer> <localleader>tl <plug>(vimtex-compile)
nmap <silent><nowait><buffer> <localleader>to <plug>(vimtex-compile-output)
nmap <silent><nowait><buffer> <localleader>tL <plug>(vimtex-compile-selected)
xmap <silent><nowait><buffer> <localleader>tL <plug>(vimtex-compile-selected)
nmap <silent><nowait><buffer> <localleader>tk <plug>(vimtex-stop)
nmap <silent><nowait><buffer> <localleader>tK <plug>(vimtex-stop-all)
nmap <silent><nowait><buffer> <localleader>te <plug>(vimtex-errors)
nmap <silent><nowait><buffer> <localleader>tc <plug>(vimtex-clean)
nmap <silent><nowait><buffer> <localleader>tC <plug>(vimtex-clean-full)
nmap <silent><nowait><buffer> <localleader>tg <plug>(vimtex-status)
nmap <silent><nowait><buffer> <localleader>tG <plug>(vimtex-status-all)

nmap <silent><nowait><buffer> <localleader>tt <plug>(vimtex-toc-open)
nmap <silent><nowait><buffer> <localleader>tT <plug>(vimtex-toc-toggle)

nmap <silent><nowait><buffer> <localleader>tv <plug>(vimtex-view)
nmap <silent><nowait><buffer> <localleader>tr <plug>(vimtex-reverse-search)

nmap <silent><nowait><buffer> <localleader>tm <plug>(vimtex-imaps-list)
