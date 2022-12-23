local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git", "clone", "--depth", "1",
    "https://github.com/wbthomason/packer.nvim", install_path
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end
  },
  git = {
    clone_timeout = 300 -- Timeout, in seconds, for git clones
  }
}

-- Install your plugins here
return packer.startup(function(use)
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" }
  use { 'windwp/nvim-autopairs' } -- autopairs using lua and treesitter

  use { 'nvim-tree/nvim-web-devicons' } -- icons using lua
  use { 'nvim-tree/nvim-tree.lua' } -- replace for nerdtree in lua

  use { 'nvim-lualine/lualine.nvim' } -- Statusline using lua
  use { 'EdenEast/nightfox.nvim' } -- lua theme using treesitter
  use { 'p00f/nvim-ts-rainbow' } -- colorize closing brackets
  use { 'nvim-treesitter/nvim-treesitter' } -- make a tree of relations. Used by some plugins
  use { 'liuchengxu/vista.vim' } -- View the code symbols references using lua
  use { 'RRethy/vim-illuminate' } -- Highlight identical words using lua
  use { 'phaazon/hop.nvim' } -- Jump quickly to a certaing part of the code using lua
  use { 'numToStr/Comment.nvim' } -- Comments using lua
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
  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then require("packer").sync() end
end)