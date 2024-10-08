
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

" Auto-completion behavior
set completeopt=menu,menuone,popup

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

" Automatically install vim-plug on the first run
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" LSP
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'
"Plug 'nkrkv/nvim-treesitter-rescript'

" Language support
Plug 'rescript-lang/vim-rescript'
Plug 'thalesmello/lkml.vim' " Looker ML
Plug 'sheerun/vim-polyglot'
Plug 'prisma/vim-prisma'

" Editing
Plug 'AndrewRadev/sideways.vim' " swap arguments, arg object
Plug 'bkad/CamelCaseMotion' " camelAndSnake_case_Motions
Plug 'scrooloose/nerdcommenter' " comment blocks
Plug 'tpope/vim-abolish' " %Subvert
Plug 'tpope/vim-surround' " surrounding quotes, braces, etc

" Color schemes
Plug 'rakr/vim-one'
Plug 'rafamadriz/neon'
Plug 'sainnhe/sonokai'

" UI
Plug 'fholgado/minibufexpl.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Navigation
Plug 'jremmen/vim-ripgrep' " :Rg
Plug 'moll/vim-bbye' " bdelete

" Fuzzy stuff
Plug '/usr/bin/fzf' " FZF relies on the global fzf tool installation
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Auto-completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

call plug#end()

" ===========================================================================
" Colors
" ===========================================================================

set background=dark
set termguicolors

" Sonokai theme customization
let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 1

function! s:sonokai_custom() abort
  highlight! link TSAnnotation Grey
  highlight! link TSAttribute GreenItalic
  highlight! link TSBoolean OrangeItalic
  highlight! link TSCharacter Yellow
  highlight! link TSComment Comment
  highlight! link TSConditional Red
  highlight! link TSConstBuiltin Orange
  highlight! link TSConstMacro Orange
  highlight! link TSConstant Orange
  highlight! link TSConstructor Green
  highlight! link TSException Red
  highlight! link TSField Green
  highlight! link TSFloat Orange
  highlight! link TSFuncBuiltin Green
  highlight! link TSFuncMacro Green
  highlight! link TSFunction Green
  highlight! link TSInclude Red
  highlight! link TSKeyword Red
  highlight! link TSKeywordFunction Red
  highlight! link TSKeywordOperator Red
  highlight! link TSLabel Red
  highlight! link TSMethod Green
  highlight! link TSNamespace Purple
  highlight! link TSNone Fg
  highlight! link TSNumber Orange
  highlight! link TSOperator Red
  highlight! link TSParameter Yellow
  highlight! link TSParameterReference Yellow
  highlight! link TSProperty Green
  highlight! link TSPunctBracket Grey
  highlight! link TSPunctDelimiter Grey
  highlight! link TSPunctSpecial Yellow
  highlight! link TSRepeat Red
  highlight! link TSString Blue
  highlight! link TSStringEscape Red
  highlight! link TSStringRegex Red
  highlight! link TSStructure OrangeItalic
  highlight! link TSSymbol Fg
  highlight! link TSTag Purple
  highlight! link TSTagDelimiter Red
  highlight! link TSText Green
  highlight! link TSStrike Grey
  highlight! link TSMath Yellow
  highlight! link TSType PurpleItalic
  highlight! link TSTypeBuiltin PurpleItalic
  highlight! link TSURI markdownUrl
  highlight! link TSVariable Fg
  highlight! link TSVariableBuiltin OrangeItalic
endfunction

augroup SonokaiCustom
  autocmd!
  autocmd ColorScheme sonokai call s:sonokai_custom()
augroup END

colorscheme sonokai

" ===========================================================================
" Filetypes
" ===========================================================================

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" Enable custom syntax highlight
augroup ftmapping
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
  au! BufRead,BufNewFile *.mdx setfiletype markdown
augroup end

" Custom settings for file types
augroup indentaition
  au! FileType javascript setlocal sw=2 sts=2 signcolumn=yes
  au! FileType javascriptreact setlocal sw=2 sts=2 signcolumn=yes
  au! FileType typescript setlocal sw=2 sts=2 signcolumn=yes
  au! FileType typescriptreact setlocal sw=2 sts=2 signcolumn=yes
  au! FileType json setlocal sw=2 sts=2
  au! FileType yaml setlocal sw=2 sts=2
  au! FileType reason setlocal sw=2 sts=2 signcolumn=yes
  au! FileType rescript setlocal sw=2 sts=2 signcolumn=yes
  au! FileType html setlocal sw=2 sts=2
  au! FileType cpp setlocal sw=4 sts=4
  au! FileType tex setlocal sw=2 sts=2 wrap
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

" ===========================================================================
" Treesitter
" ===========================================================================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { "javascript", "c" },
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  playground = {
    enable = true,
  },
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      -- Mnemonic decoding
      -- a/i  = around/inner
      -- l    = language
      -- f    = function
      -- m    = method
      -- c    = class
      -- b    = block
      -- a    = argument
      -- p    = parameter
      -- ( )  = call
      keymaps = {
        ["alf"] = "@function.outer",
        ["ilf"] = "@function.inner",
        ["alm"] = "@function.outer",
        ["ilm"] = "@function.inner",
        ["alc"] = "@class.outer",
        ["ilc"] = "@class.inner",
        ["alb"] = "@block.outer",
        ["ilb"] = "@block.inner",
        ["ala"] = "@parameter.outer",
        ["ila"] = "@parameter.inner",
        ["alp"] = "@parameter.outer",
        ["ilp"] = "@parameter.inner",
        ["al)"] = "@call.outer",
        ["il)"] = "@call.inner",
        ["al("] = "@call.outer",
        ["il("] = "@call.inner",
      },
    },

    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
}
EOF

lua <<EOF
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.rescript = {
  install_info = {
    url = "~/devel/playground/tree-sitter-rescript", -- local path or git repo
    files = {"src/parser.c", "src/scanner.c"},
  }
}
EOF

" ===========================================================================
" LSP
" ===========================================================================
lua << EOF

require("mason").setup()
local lsp = require('lspconfig')

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local kopts = { silent = true, buffer = args.buf }
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, kopts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_prev({ float = true }) end, kopts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev({ float = true }) end, kopts)
  end,
})

-- ReScript
lsp.rescriptls.setup {
  cmd = {'node', os.getenv("HOME") .. '/.local/share/nvim/plugged/vim-rescript/server/out/server.js', '--stdio'},
  flags = {
    debounce_text_changes = 150,
  }
}

-- TypeScript
lsp.tsserver.setup {
  flags = {
    debounce_text_changes = 150,
  }
}

EOF

" ===========================================================================
" Plugin settings
" ===========================================================================

" -------------------------------------
" Minibuf explorer
" -------------------------------------
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

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
" AirLine
" -------------------------------------

let g:airline_theme='deus'
let g:airline#extensions#keymap#enabled = '0'
let g:airline_powerline_fonts = 1
" Minimalistic rightmost section: 45%/623  223:46
let g:airline_section_z = '%P/%L  %3l:%-2c'

" -------------------------------------
" FZF
" -------------------------------------

let g:fzf_layout = { 'down': '~20%' }

" -------------------------------------
" Cmp
" -------------------------------------

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    completion = {
      -- No distractions as I type
      autocomplete = false,
      -- Override defaults to always select the first item
      completeopt = 'menu,menuone,popup',
    },
    formatting = {
      -- No tilde ~ if autocompletion is expandable (a mini-template)
      expandable_indicator = false,
    },
    mapping = cmp.mapping.preset.insert({
      -- Do not hijack native Ctrl+P/N, allow Cmp only use them for selecting items
      -- while its popup is visible
      ['<C-n>'] = function(fallback)
        if cmp.visible() then cmp.select_next_item({ behavior = cmp.SelectBehavior.Select }) else fallback() end
      end,
      ['<C-p>'] = function(fallback)
        if cmp.visible() then cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select }) else fallback() end
      end,
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
EOF
