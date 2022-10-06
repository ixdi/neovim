# Neovim

Config files for my neovim using LUA.

Clone the repo to ```~/.config/nvim```

## Installation

Install ```nodejs``` required by Coc plugin

Install ```ripgrep``` command line utility (used by coc) [https://github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)

Install ```ctags``` command line

Install ```junegunn/vim-plug``` to manage plugins

```bash
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then run ```:PlugUpgrade``` to update vim-plug and ```:PlugUpdate``` to update all plugins

## Plugins

```vim
" classic vim
Plug 'godlygeek/tabular'                  " Tabularize
Plug 'mg979/vim-visual-multi'             " Multiple cursors
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " View markdown document while editing

" Autocomplete
Plug 'ixdi/vim-meteor-snippets'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }  " Generate jsDoc
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" Language Support
Plug 'mustache/vim-mustache-handlebars'   " Handlebars and spacebars

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
Plug 'karb94/neoscroll.nvim' " smooth scroll
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
```

## Shortcuts

```vim
let mapleader = ","

" Exit insert mode
jj

" Fast saving
<leader>w :w!<cr>

" History search
<silence> <F5> :set hlsearch! hlsearch?<CR>

" Buffer configuration
bp :bprevious<CR>
bn :bnext<CR>
bd :bdelete<CR>
bl :buffers<CR>
bda :bufdo bd<CR>

" Copy/paste between vim instances and clipboard using
y
p

" set handlebars file type
<leader>h :set filetype=handlebars<cr>

" Search and replace word under cursor (,*)
<leader>* :%s/\<<C-r><C-w>\>//<Left>

" lua tree
<F3>
" find current file in NerdTree
<silent> <leader>f

" Tabularize
<leader>t :Tabularize /
<leader>t :'<, '>Tabularize /
<leader>T :Tabularize / \zs
<leader>T :'<, '>Tabularize / \zs

" Surround
" replace tag for anotherone
<leader>st
"insert new chars wrapping word under cursor
<leader>s
" delete char on cursor
<leader>sd

" Indent
" select all file and indent
<leader>o <esc>gg=G<C-o>
" indent bracket
<leader>oo <esc>=i}

" stripwhitespace
<F7> :%s/\s\+$//e<cr>

" Sort css
<leader>so vi}:sort<CR>

" vim doge code comment autocompletion
<leader>d :DogeGenerate<cr>

" Comment lines
<leader>c

" Hop to jump quickly
nnoremap <silent> s :HopPattern<cr>
nnoremap <silent> <space>hw :HopWord<cr>
nnoremap <silent> <space>h1 :HopChar1<cr>
nnoremap <silent> <space>h2 :HopChar2<cr>
nnoremap <silent> <space>hl :HopLine<cr>

" snippets
imap <expr> <Tab>
imap <expr> <S-Tab>

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
```
