
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

Plug 'fholgado/minibufexpl.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'rakr/vim-one' " color scheme
Plug 'moll/vim-bbye' " bdelete
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

" Completion plugin for LanguageClient
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Unite everything UI
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" You/change/delete surrounding quotes, braces, etc
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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

" Map Enter in normal mode to insert blank lines above/bellow cursor
nmap <s-cr> m'O<esc>`'
nmap <cr> m'o<esc>`'

" Swap the current line with line above/below
nnoremap <silent> ]e :m .+1<CR>==
nnoremap <silent> [e :m .-2<CR>==

" -------------------------------------
" Window/split management
" -------------------------------------

" Ctrl+W is hard to press. ,w is a faster alternative
nmap <leader>h <c-w>h
nmap <leader>j <c-w>j
nmap <leader>k <c-w>k
nmap <leader>l <c-w>l
nmap <leader>w <c-w>

" Alt with + or - key to resize current window
nmap <m-=> <c-w>5+
nmap <m--> <c-w>5-

" -------------------------------------
" Language
" -------------------------------------

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> ]r :call LanguageClient#textDocument_rename()<CR>

" -------------------------------------
" Fuzzy find
" -------------------------------------
" find file
nnoremap <leader>ff :Denite file/rec<CR>
" find neighbor File
nnoremap <leader>fF :DeniteBufferDir file/rec<CR>
" find buffer
nnoremap <leader>fb :Denite buffer<CR>
" find word
nnoremap <leader>fw :Denite grep:. -mode=normal<CR>
" find Word in neighbors
nnoremap <leader>fW :DeniteBufferDir grep:. -mode=normal<CR>
" *-find in project files
nnoremap <leader>8 :DeniteCursorWord grep:. -mode=normal<CR>

" ===========================================================================
" Plugin settings
" ===========================================================================

" Minibuf explorer
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" NERDTree
nmap <leader>n :NERDTree<cr>
let NERDTreeIgnore=['\~$', '\.orig$', '\.pyc$', '\.pyo$', '\.o$', '\.sqlite$', '\.aux$', '\.pdf$', '__pycache__', 'tags']

" Ctrl+p
let g:ctrlp_custom_ignore = 'node_modules\|dist\|lib'

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
" Denite
" -------------------------------------

" File listing with ripgrep
call denite#custom#var('file/rec', 'command',
    \ ['rg', '--files'])

" Grepping with ripgrep
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
    \ ['--hidden', '--vimgrep', '--no-heading', '--smart-case'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Ctrl+n/Ctrl+p to navigate through lines in insert mode
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

" Reset to a quarter of window height on resize
augroup deniteresize
  autocmd!
  autocmd VimResized,VimEnter * call
    \ denite#custom#option('default','winheight', winheight(0) / 4)
augroup end

" Minimalistic highlight: only matched characters
call denite#custom#option('default', 'highlight_matched_char', 'Keyword')
call denite#custom#option('default', 'highlight_matched_range', 'Normal')
