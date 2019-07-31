# neovim
Config files for my neovim

## Install
junegunn/vim-plug
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Then run ```:PlugUpgrade to update plugin```

## Plugins
```
" UI and colors
Plug 'flrnprz/plastic.vim'
Plug 'lilydjwg/colorizer'                 " show colors from CSS
Plug 'vim-airline/vim-airline'            " Handy info
Plug 'ryanoasis/vim-devicons'             " icons
Plug 'sheerun/vim-polyglot'               " Rules for different languages


" Project Navigation
Plug 'dyng/ctrlsf.vim'                    " Search features
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'        " show git changes in nerdtree
Plug '/usr/local/opt/fzf'                 " FuzzyFinder need to be installed first on the system
Plug 'junegunn/fzf.vim'

" File Navigation
Plug 'easymotion/vim-easymotion'          " Move like the wind!
Plug 'haya14busa/incsearch.vim'           " Better search highlighting

" Editing
Plug 'tpope/vim-surround'                 " Change word surroundings
Plug 'tomtom/tcomment_vim'                " Comments
Plug 'mg979/vim-visual-multi'             " select multi
Plug 'ntpeters/vim-better-whitespace'     " show and remove end whitespaces
Plug 'jiangmiao/auto-pairs'               " autoclose tags
Plug 'alvan/vim-closetag'                 " html autoclose
Plug 'godlygeek/tabular'                  " Tabularize

" Git
Plug 'tpope/vim-fugitive'                 " Git stuff in Vim
Plug 'airblade/vim-gitgutter'             " Git show changes

" Task Running
" Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'ixdi/vim-meteor-snippets'
Plug 'kkoomen/vim-doge'                   " Generate jsDoc

" Language Support
Plug 'mustache/vim-mustache-handlebars'   " Handlebars and spacebars
```
