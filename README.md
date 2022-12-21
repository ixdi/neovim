# Neovim

Config files for my neovim using LUA.

Clone the repo to ```~/.config/nvim```

## Installation

Install ```nodejs``` 

Install ```ripgrep```

Install ```lazygit``` command line

Install ```xsel and wl-clipboard```

Install ```ctags``` command line

Install ```pip install pynvim``` to manage plugins

Install ```npm install -g neovim``` to manage plugins

markdown-preview needs special atention ```cd ~/.local/share/nvim/site/pack/markdown-preview/app && yarn```

Then run ```nvim``` to install all for the first time

## Plugins with Packer

```vim
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" }
  use { 'windwp/nvim-autopairs' } -- autopairs using lua and treesitter
  -- use { 'numToStr/Comment.nvim' }

  use { 'nvim-tree/nvim-web-devicons' } -- icons using lua
  use { 'nvim-tree/nvim-tree.lua' } -- replace for nerdtree in lua

  use { 'nvim-lualine/lualine.nvim' } -- Statusline using lua
  use { 'EdenEast/nightfox.nvim' } -- lua theme using treesitter
  use { 'p00f/nvim-ts-rainbow' } -- colorize closing brackets
  use { 'nvim-treesitter/nvim-treesitter' } -- make a tree of relations. Used by some plugins
  use { 'liuchengxu/vista.vim' } -- View the code symbols references using lua
  use { 'RRethy/vim-illuminate' } -- Highlight identical words using lua
  use { 'phaazon/hop.nvim' } -- Jump quickly to a certaing part of the code using lua
  -- use { 'numToStr/Comment.nvim' } -- Comments using lua
  use { 'windwp/nvim-ts-autotag' } -- Close tags using lua and treesitter
  use { 'gbprod/yanky.nvim' } -- extended yank using lua
  use { 'folke/todo-comments.nvim' } -- to highlight todo sections
  use { 'kylechui/nvim-surround' } -- replace pair chars using lua
  use { 'lewis6991/gitsigns.nvim' } -- Git integration using lua
  use { 'jdhao/better-escape.vim' } -- scape quickly

  use { 'neovim/nvim-lspconfig' } -- language server
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { "saadparwaiz1/cmp_luasnip" }
  use { 'ray-x/cmp-treesitter' }

  use {"L3MON4D3/LuaSnip" }
  use { "rafamadriz/friendly-snippets" }
  --  use { 'dcampos/nvim-snippy' } -- snippets using lua
  -- use { 'dcampos/cmp-snippy' } -- to use snippy with cmp
  use {"ixdi/vim-meteor-snippets" }

  use { 'nvim-telescope/telescope.nvim' }
  use { 'williamboman/mason.nvim' } -- easy to install language servers
  use { 'williamboman/mason-lspconfig.nvim' }
  -- use { 'onsails/lspkind.nvim' } -- view pictograms to lsp
  use { 'ray-x/lsp_signature.nvim' } -- show signature of the functions
  use { 'norcalli/nvim-colorizer.lua' } -- colorizer
  -- use { 'nathom/filetype.nvim' } -- 175x faster than vim
  use { 'lukas-reineke/indent-blankline.nvim' } -- show indent line
  use { 'danymat/neogen' } -- add comments with lua support
  use { 'folke/zen-mode.nvim' }
  use { 'jose-elias-alvarez/null-ls.nvim' }
  use { 'kdheepak/lazygit.nvim' }
  use { 'akinsho/bufferline.nvim' }
  use { 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim' }
  use { "lewis6991/impatient.nvim" }
  
  use { 'mg979/vim-visual-multi' } -- icons using lua
  use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
```

## Shortcuts

```vim
let mapleader = ","

" Exit insert mode
jj

" Fast saving
<leader>w

" History search
<F5>

" Buffer configuration
bp buffer previous
bn buffer next
bd buffer delete
bl buffers list
bda buffer do

" Copy/paste between vim instances and clipboard using
y
p

" set handlebars file type
<leader>h

" Search and replace word under cursor (,*)
<leader>*

" lua tree
<space>e

" find current file in NerdTree
<leader>f

" Surround
" replace tag for anotherone
<leader>st
"insert new chars wrapping word under cursor
<leader>s
" delete char on cursor
<leader>sd

" Indent
" select all file and indent
<leader>o
" indent bracket
<leader>oo

" stripwhitespace
<F7>

" Sort css
<leader>so

" comment autocompletion
<leader>d code
<leader>dc class
<leader>dt type
<leader>df file

" Comment lines visually
<leader>c

" Hop to jump quickly
s :HopPattern<cr>
<space>hw find word starting with...
<space>h1 jump char 1
<space>h2 jump char 2
<space>hl jump line

" snippets
imap <expr> <Tab>
imap <expr> <S-Tab>

" Markdown preview
<space>m

" Telescope
<space>f find_files
<space>u recent files
<C-f> grep string in a project
<C-l> show last list
<leader>fg live_grep
<space>b buffers
<leader>s show symbols
<space>err diagnostics
<space>d lsp_definitions
<space>r lsp_references
<space>i lsp_implementations
<space>ri lsp_incoming_calls
<space>ro lsp_outgoing_calls

" Lazzy git
<space>g

" Toggle diagnostics
<leader>dv

" Relative number
<learder>n

" Zen mode
<leader>z
```
