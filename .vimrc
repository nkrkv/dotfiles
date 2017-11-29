
set nocompatible    " use Vim settings, rather then Vi settings;
                    "   this must be first, because it changes other options as a side effect.
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set nobackup        " do not keep a backup files at all
set noswapfile      " no recovery *.swp files
set history=50      " keep 50 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching
set hlsearch        " highlight last used search pattern
set mouse=a         " enable mouse
set nowrap          " no word wrap
set autoindent      " always autoindent
set scrolloff=5     " keep at minimum few lines from top and bottom when scrolling
set wildmenu        " autocompletion of commands
set notimeout       " wait for ambigous key in key map forever
set hidden          " allow moving around and leaving dirty files be
set laststatus=2    " make sure that status line is always shown as
                    "   the second last line in the editor window
set tags=tags       " look for tags only in cwd/tags file
set nofoldenable    " no folding
set linebreak       " break on word boundaries if word wrap enabled
set listchars=eol:$,tab:–→,trail:~,extends:>,precedes:<,nbsp:•

" Ignored listing patterns
set wildignore+=*.o,*.pyc,*.orig,.hg,.git,.svn,*.jpg,*.png

syntax on  " switch syntax highlighting on

" Vundle init
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'leafgarland/typescript-vim'
Plugin 'majutsushi/tagbar'    " requires `npm install -g jsctags`
Plugin 'moll/vim-bbye'
Plugin 'mxw/vim-jsx'
Plugin 'nginx.vim'
Plugin 'othree/html5.vim'
Plugin 'othree/yajs.vim'
Plugin 'raichoo/purescript-vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'ternjs/tern_for_vim'  " depends on `npm install` inside its bundle dir
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'wavded/vim-stylus'
call vundle#end()             " required

filetype plugin indent on   " enable file type detection, use the default filetype settings

" Tab settings
set expandtab       " expand tabs to spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

if has("gui_running")
    set guioptions-=m           " remove menu bar
    set guioptions-=T           " remove toolbar
    set lines=58 columns=165    " default window size
    set guiheadroom=75          " vertical reserve for decorations (two panels + title bar)
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
    colors rootwater            " default color scheme
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \     exe "normal! g`\"" |
    \ endif
augroup END

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
  au! FileType cpp set sw=4 sts=4
augroup end

" Language settings
set keymap=russian-jcukenwin    " переключение на русский по Ctrl+^
set iminsert=0                  " по умолчанию -- английский для ввода
set imsearch=0                  " по умолчанию -- английский для поиска
set spelllang=ru_yo,en_us       " проверка через словарь с Ё и через английский словарь
highlight lCursor guifg=NONE guibg=Cyan " подсветка курсора при включенном русском


" ===========================================================================
" Shortcuts
" ===========================================================================

let mapleader = ","     " remap <leader> to comma

nnoremap ; :
nnoremap <m-;> ;
nnoremap <m-,> ,

" More natural behavior on wrapped lines
nnoremap j gj
nnoremap k gk

" .vimrc edit and source
nmap <F5> :edit ~/.vimrc<cr>
nmap <S-F5> :source ~/.vimrc<cr>

" Map Enter in normal mode to insert blank lines above/bellow cursor
nmap <s-cr> m'O<esc>`'
nmap <cr> m'o<esc>`'

" ,h to clear search highlight
nmap <silent> <leader>/ :nohl<cr>

" Nifty window resize
nmap <m-=> <c-w>5+
nmap <m--> <c-w>5-

" Shortcuts for copying and pasting
nmap <leader>y m'gg"+yG''
vmap <leader>y "+y
map <leader>p "+p
map <leader>P "+P

" Copy current buffer path
map <leader>cp :let @+ = expand("%")<cr>

" Home / end alternative
map <c-h> ^
map <c-l> $

" Faster up / down
map <c-j> 3j
map <c-k> 3k

" Move lines up and down
nnoremap <silent> ]e :m .+1<CR>==
nnoremap <silent> [e :m .-2<CR>==

" Window navigation
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l
nmap <leader>w <c-w>

" Buffer close
nmap <leader>d :Bdelete<cr>

" Python shortcuts
augroup pykey
    autocmd!
    autocmd FileType python call PythonKeystrokes()
augroup END
function! PythonKeystrokes()
    " Inserts call to super-method at current cursor position
    imap <buffer> <c-s>s super<c-v>(<c-v>)<esc>m'[c_wye`'Pa, self<esc>m'[f_wye''A.<esc>pa<c-v>(<c-v>)<esc>i

    " Insert multiline quotes and set cursor inbetween
    imap <buffer> <c-s>" <c-v>"<c-v>"<c-v>"<c-v>"<c-v>"<c-v>"<esc>hhi
    imap <buffer> <c-s>' <c-v>'<c-v>'<c-v>'<c-v>'<c-v>'<c-v>'<esc>hhi

    imap <buffer> <c-s>e #!/usr/bin/env python<cr>
    imap <buffer> <c-s>u # -*- coding: utf-8; -*-<cr>

    nmap <buffer> [r ?^\s*pass\s*$<cr>Vp:nohl<cr>
    nmap <buffer> ]r /^\s*pass\s*$<cr>Vp:nohl<cr>
endfunction

" Tags generation for current file (f) and direcory (d)
nmap <silent> <leader>tf :exe ":silent !ctags %"<cr>
nmap <silent> <leader>td :exe ":silent !ctags -R ."<cr>


" ===========================================================================
" Plugin settings
" ===========================================================================

" Minibuf explorer
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Python
let python_highlight_doctests = 1

" NERDTree
nmap <leader>n :NERDTree<cr>
let NERDTreeIgnore=['\~$', '\.orig$', '\.pyc$', '\.pyo$', '\.o$', '\.sqlite$', '\.aux$', '\.pdf$', '__pycache__', 'tags']

" Tag list
nmap <leader>tt :Tagbar<cr>

" Ack grep
let g:ackprg="ack-grep\\ -H\\ --nocolor\\ --nogroup\\ --column"

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Ctrl+p
let g:ctrlp_custom_ignore = 'node_modules\|dist'

" AirLine
let g:airline_theme='luna'

if has("gui_running")
    let g:airline_powerline_fonts = 1

    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    " unicode symbols
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.whitespace = 'Ξ'

    " airline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = ''
endif
