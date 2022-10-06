" terminal font: nerd-jetbrains-mono
let mapleader = ","
let &runtimepath .= "," . $DOTFILES . "/nvim"  " Add DOTFILES to runtimepath
let &packpath .= "," . $DOTFILES . "/nvim"

set autowrite                      " Automatically :write before running commands
set backspace=2                    " Backspace deletes like most programs in insert mode
set clipboard=unnamedplus
set completeopt=menu,menuone,noselect
set conceallevel=0                 " Text like " is shown normally
set expandtab
set foldmethod=indent
set gdefault                       " By default add g flag to search/replace. Add g to toggle.
set hidden
set history=200
set inccommand=nosplit
set laststatus=2                   " Always display the status line
set list listchars=tab:»·,trail:·  " Display extra whitespace characters
set mouse=a                        " Enable mouse in all in all modes.
set nobackup
set nofoldenable                   " Disable folding
set nolist                         " Don't show whitespace, since saving will clean it up automatically anyway
set noshowmode
set noswapfile                     " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set nowritebackup
set ruler                          " Show the cursor position all the time
set scrolloff=3
set shell=zsh                      " Set bash as the prompt for Vim
set shiftround
set shiftwidth=2
set showcmd                        " Display incomplete commands
set smartindent
" set cindent
set tabstop=2
set textwidth=120
set timeoutlen=500
set ttimeoutlen=0
set undodir=~/.config/nvim/undodir
set undofile                       " Maintain undo history between sessions

" Line numbers
set number
set numberwidth=5

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
" set spellfile=$HOME/.vim-spell-en.utf-8.add

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Autocommands
filetype plugin indent on
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

" Automatically clean trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e
" Remove trialing lines
autocmd BufWritePre * :%s#\($\n\s*\)\+\%$##e
" Mark extra whitespace as red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+\%#\@<!$/

" Specify plugins
call plug#begin()

" classic vim
Plug 'godlygeek/tabular'                  " Tabularize
Plug 'mg979/vim-visual-multi'             " Multiple cursors
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " View markdown document while editing

Plug 'mustache/vim-mustache-handlebars'

" Autocomplete
Plug 'ixdi/vim-meteor-snippets'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }  " Generate jsDoc
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" Neovim LUA
" Some references here: https://jdhao.github.io/nvim-config/
Plug 'nvim-lualine/lualine.nvim' " Statusline using lua
Plug 'EdenEast/nightfox.nvim' " lua theme using treesitter
Plug 'kyazdani42/nvim-web-devicons' " icons using lua
Plug 'kyazdani42/nvim-tree.lua' " replace for nerdtree in lua
Plug 'p00f/nvim-ts-rainbow' " colorize closing brackets
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " make a tree of relations. Used by some plugins
Plug 'liuchengxu/vista.vim' " View the code symbols references using lua
Plug 'RRethy/vim-illuminate' " Highlight identical words using lua
Plug 'phaazon/hop.nvim' " Jump quickly to a certaing part of the code using lua
Plug 'numToStr/Comment.nvim' " Comments using lua
Plug 'windwp/nvim-autopairs' " autopairs using lua and treesitter
Plug 'windwp/nvim-ts-autotag' " Close tags using lua and treesitter
Plug 'gbprod/yanky.nvim' " extended yank using lua
Plug 'nvim-lua/plenary.nvim' " lua functions I don't want to write twice
Plug 'folke/todo-comments.nvim' " to highlight todo sections
Plug 'kylechui/nvim-surround' " replace pair chars using lua
Plug 'lewis6991/gitsigns.nvim' " Git integration using lua
Plug 'jdhao/better-escape.vim' " scape quickly
Plug 'williamboman/mason.nvim' " easy to install language servers
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig' " language server
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'dcampos/nvim-snippy' " snippets using lua
Plug 'dcampos/cmp-snippy' " to use snippy with cmp
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'RubixDev/mason-update-all' " to update all servers

call plug#end()

" Load plugin configurations
" ==========================

" History search
nnoremap <silent> <F5> :set hlsearch! hlsearch?<CR>

" syntax and color
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_ut=                " fix 256 colors in tmux http://sunaku.github.io/vim-256color-bce.html
if (has("termguicolors"))  " set true colors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
  " set notermguicolors
endif
set background=dark
let g:one_allow_italics = 1 " italic for comments
colorscheme nordfox

if filereadable($DOTFILES . "/nvim/init.local.vim")
  source $DOTFILES/nvim/init.local.vim
endif

" Buffer configuration
nnoremap bp :bprevious<CR>
nnoremap bn :bnext<CR>
nnoremap bd :bdelete<CR>
nnoremap bl :buffers<CR>
nnoremap bda :bufdo bd<CR>

" Clear last search (,qs)
map <silent> <leader>m <Esc>:noh<CR>

" set handlebars file type
nmap <leader>h :set filetype=handlebars<cr>

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

"nore Tabularize
noremap <leader>t :Tabularize /
vnoremap <leader>t :'<, '>Tabularize /
noremap <leader>T :Tabularize / \zs
vnoremap <leader>T :'<, '>Tabularize / \zs

" Indent
" select all file and indent
noremap <silent> <leader>o <esc>gg=G<C-o>
" indent bracket
noremap <silent> <leader>oo <esc>=i}

" stripwhitespace
noremap <silent><special> <F7> :%s/\s\+$//e<cr>

" Sort blocks
nnoremap <silent> <leader>so vi}:sort<CR>

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>r :e<cr>

" Multiple cursors
let g:multi_cursor_exit_from_insert_mode = 1
let g:multi_cursor_exit_from_visual_mode = 1

" autoload
au BufReadPost,BufNewFile *.html set filetype=handlebars
au BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.prettierrc set filetype=json
au BufRead,BufNewFile *.scss set filetype=scss.css

" Markdown preview
nnoremap <silent> <space>m <Plug>MarkdownPreviewToggle

" vim doge
" map <leader>d :DogeGenerate<cr>
let g:doge_mapping = '<leader>d'
let g:doge_comment_interactive = 1
let g:doge_mapping_comment_jump_forward = '<leader>n'
let g:doge_mapping_comment_jump_backward = '<A-p>'
let g:doge_doc_standard_python = 'sphinx'

" pydocstring
nmap <silent> <leader>dd <Plug>(pydocstring)
" sphinx, google or numpy
let g:pydocstring_formatter = 'sphinx'

" LUA configs
" ===========
lua require('init')

" tree using lua
map <silent><special> <space>e :NvimTreeToggle<CR>
map <silent><special> <F3> :NvimTreeToggle<CR>
nmap <silent> <leader>f :NvimTreeFindFile<CR>

nnoremap <silent> <space>t :TodoQuickFix<cr>

" Surround
" change char on cursor with new one, cs"' substitute " by '
nmap <silent> <leader>sc <esc>cs
" replace tag for anotherone
nmap <silent> <leader>st <esc>cst
"insert new chars wrapping word under cursor
nmap <silent> <leader>s <esc>ysiw
"delete around. Using dst will remove the enclosing tag
nmap <silent> <leader>ds <esc>ds

" Illuminate word under cursor
nnoremap <silent> <space>l :IlluminateToggle<cr>
hi def IlluminatedWordText gui=bold
hi def IlluminatedWordRead gui=bold
hi def IlluminatedWordWrite gui=bold

" view symbols
nnoremap <silent> <space>s :Vista!!<cr>
" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Comment
map <silent> <leader>c gcc

" Hop to jump quickly
nnoremap <silent> s :HopPattern<cr>
nnoremap <silent> <space>hw :HopWord<cr>
nnoremap <silent> <space>h1 :HopChar1<cr>
nnoremap <silent> <space>h2 :HopChar2<cr>
nnoremap <silent> <space>hl :HopLine<cr>

" scape quickly
let g:better_escape_shortcut = 'jj'
let g:better_escape_interval = 200

" snippets
imap <expr> <Tab> snippy#can_expand_or_advance() ? '<Plug>(snippy-expand-or-advance)' : '<Tab>'
imap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
smap <expr> <Tab> snippy#can_jump(1) ? '<Plug>(snippy-next)' : '<Tab>'
smap <expr> <S-Tab> snippy#can_jump(-1) ? '<Plug>(snippy-previous)' : '<S-Tab>'
xmap <Tab> <Plug>(snippy-cut-text)

" Telescope
nnoremap <silent> <space>f <cmd>Telescope find_files<cr>
nnoremap <silent> <space>u <cmd>Telescope oldfiles<cr>
nnoremap <C-f> <cmd>Telescope grep_string<cr>
nnoremap <C-l> <cmd>Telescope quickfix<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <silent> <space>b <cmd>Telescope buffers<cr>
nnoremap <leader>s <cmd>Telescope lsp_document_symbols<cr>
nnoremap <silent> <space>err <cmd>Telescope diagnostics<cr>
nnoremap <silent> <space>d <cmd>Telescope lsp_definitions<cr>
nnoremap <silent> <space>r <cmd>Telescope lsp_references<cr>
nnoremap <silent> <space>i <cmd>Telescope lsp_implementations<cr>
nnoremap <silent> <space>g <cmd>Telescope git_status<cr>
nnoremap <silent> <space>ri <cmd>Telescope lsp_incoming_calls<cr>
nnoremap <silent> <space>ro <cmd>Telescope lsp_outgoing_calls<cr>
nnoremap <leader>r :'<,'>Telescope lsp_range_code_actions<cr>
nnoremap <leader>p :Telescope yank_history<cr>
nnoremap <silent> <space><space> :lua vim.lsp.buf.hover()<cr>

" Run formatter before saving
autocmd BufWritePre * :lua vim.lsp.buf.format()
