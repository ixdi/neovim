# Neovim
Config files for my neovim. See Coc Project at https://github.com/neoclide/coc.nvim

Clone the repo to ```~/.config/nvim```

## Install
Install ```nodejs``` required for Coc plugin

Install ```ripgrep``` command line utility (used by coc) https://github.com/BurntSushi/ripgrep

Install ```ctags``` command line

Install ```junegunn/vim-plug```
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Then run ```:PlugUpgrade to update vim-plug``` and ```:PlugUdate to update all plugins``` to update all plugins

## Plugins
```
" UI and colors
Plug 'flrnprz/plastic.vim'
Plug 'itchyny/lightline.vim'              " Lightline status bar
Plug 'mengelbrecht/lightline-bufferline'  " Buffer show for lightline
Plug 'ryanoasis/vim-devicons'             " icons
Plug 'sheerun/vim-polyglot'               " Rules for different languages

" Project Navigation
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'        " show git changes in nerdtree

" Editing
Plug 'tpope/vim-surround'                 " Change word surroundings
Plug 'tomtom/tcomment_vim'                " Comments
Plug 'alvan/vim-closetag'                 " html autoclose
Plug 'godlygeek/tabular'                  " Tabularize
Plug 'terryma/vim-multiple-cursors'       " Multiple cursors
Plug 'mattn/emmet-vim'                    " Emmet
Plug 'gko/vim-layout'                     " Layout
Plug 'wellle/targets.vim'                 " More text objects to operate on

" Git
Plug 'tpope/vim-fugitive'                 " Git stuff in Vim
Plug 'airblade/vim-gitgutter'             " Git show changes

" Task Running
" Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ixdi/vim-meteor-snippets'
Plug 'kkoomen/vim-doge'                   " Generate jsDoc

" Language Support
Plug 'mustache/vim-mustache-handlebars'   " Handlebars and spacebars
```

Finally install coc plugins
```
:CocInstall coc-yank coc-tsserver coc-todolist coc-snippets coc-prettier coc-pairs coc-lists coc-json coc-html coc-highlight coc-eslint coc-css coc-python
```
