# Neovim
Config files for my neovim. See Coc Project at https://github.com/neoclide/coc.nvim

Clone the repo to ```~/.config/nvim```

## Installation
Install ```nodejs``` required by Coc plugin

Install ```ripgrep``` command line utility (used by coc) https://github.com/BurntSushi/ripgrep

Install ```ctags``` command line

Install ```junegunn/vim-plug```
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
Then run ```:PlugUpgrade``` to update vim-plug and ```:PlugUpdate``` to update all plugins

## Plugins
```
" UI and colors
Plug 'flrnprz/plastic.vim'                " Plastic theme
Plug 'itchyny/lightline.vim'              " Lightline status bar
" Plug 'mengelbrecht/lightline-bufferline'  " Buffer show for lightline
Plug 'maximbaz/lightline-ale'             " show errors in statusline
Plug 'josa42/vim-lightline-coc'           " show coc state in statusline
Plug 'ryanoasis/vim-devicons'             " icons
Plug 'sheerun/vim-polyglot'               " Syntax and indent for different languages
Plug 'gko/vim-layout'                     " Layout

" Project Navigation
Plug 'preservim/nerdtree'                 " file explorer
Plug 'Xuyuanp/nerdtree-git-plugin'        " show git changes in nerdtree
Plug 'Yggdroot/indentLine'                " show vertical lines in indented code

" Editing
Plug 'tpope/vim-surround'                 " Change word surroundings
Plug 'tomtom/tcomment_vim'                " Comments
Plug 'alvan/vim-closetag'                 " html autoclose
Plug 'godlygeek/tabular'                  " Tabularize
Plug 'mg979/vim-visual-multi'            " Multiple cursors
Plug 'mattn/emmet-vim'                    " Emmet
Plug 'wellle/targets.vim'                 " More text objects to operate on

" Git
Plug 'tpope/vim-fugitive'                 " Git stuff in Vim
Plug 'airblade/vim-gitgutter'             " Git show changes

" Task Running
" Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }

" COC is the base platform for multiple features!
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Autocomplete
Plug 'ixdi/vim-meteor-snippets'
Plug 'kkoomen/vim-doge'                   " Generate jsDoc

" Language Support
Plug 'mustache/vim-mustache-handlebars'   " Handlebars and spacebars
```

Finally install coc plugins
```
:CocInstall coc-yank coc-tsserver coc-todolist coc-snippets coc-prettier coc-pairs coc-lists coc-json coc-html coc-highlight coc-eslint coc-css coc-python
```
## Shortcuts
```
<leader>,

" Exit insert mode
jj

" Fast saving
nmap <leader>w :w!<cr>

" History search
nnoremap <silence> <F5> :set hlsearch! hlsearch?<CR>

" Remap the increment and decrement features of Vim
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" move between views using Alt instead of Ctrl
nmap <A-j> <C-w>j
nmap <A-k> <C-w>k
nmap <A-l> <C-w>l
nmap <A-h> <C-w>h
nmap <A-Up> <C-w>_
nmap <A-Right> <C-w>|
nmap <A-Down> <C-w>=

" Buffer configuration
nnoremap bp :bprevious<CR>
nnoremap bn :bnext<CR>
nnoremap bd :bdelete<CR>
nnoremap bl :buffers<CR>
nnoremap bda :bufdo bd<CR>

" Copy/paste between vim instances
vmap <leader>y "*y
nmap <leader>p "*p
nmap p ]p
nmap P ]P

" set handlebars file type
nmap <leader>h :set filetype=handlebars<cr>

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

"NerdTree
map <F3> :NERDTreeToggle<CR>

" Tabularize
nmap <leader>t :Tabularize /
vmap <leader>t :'<, '>Tabularize /
nmap <leader>T :Tabularize / \zs
vmap <leader>T :'<, '>Tabularize / \zs

" Surround
" change char on cursor with new one, cs"' substitute " by '
nmap <leader>s <esc>cs
" replace tag for anotherone
nmap <leader>st <esc>cstt
"insert new chars wrapping word under cursor
nmap <leader>sw <esc>ysiw

" Fugitive git
nnoremap <F12> :Gstatus<CR>
nnoremap <F4> :Gcommit<cr>

" Indent
" select all file and indent
nmap <leader>o <esc>gg=G<C-o>
" indent bracket
nmap <leader>oo <esc>=i}

" stripwhitespace
noremap <F7> :%s/\s\+$//e<cr>

" Sort css
nnoremap <leader>so vi}:sort<CR>

" Import cost
" map <leader>ic :ImportCost<cr>

" vim doge code comment autocompletion
map <leader>d :DogeGenerate<cr>

" Comment lines
map <leader>c <c-_><c-_>

" Show different lists
nmap <F5> <esc>:CocList -A --normal yank<cr>
nmap <F6> <esc>:CocList --number-select tags<cr>
nmap <C-p> <esc>:CocList --number-select --normal mru<cr>
nmap <F8> <esc>:CocList --number-select buffers<cr>
nmap <F9> <esc>:CocList --number-select files<cr>
nmap <F10> <esc>:CocUpdate<cr>
nmap <C-l> <esc>:CocListResume<cr>
nmap <C-f> <esc>:CocList grep<cr>

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <leader>vf :exe 'CocList --normal --input='.expand('<cword>').' grep'<cr>

" goto definitions
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>di <Plug>(coc-implementation)
" coc eslint errors keymappings
nmap <silent> <leader>ep <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>en <Plug>(coc-diagnostic-next)

"tags
nmap <leader>t <C-]>
nmap <leader>tt <C-t>

"session
nmap <silent> <leader>ss :CocCommand session.save<cr>
nmap <silent> <leader>sl :CocCommand session.load<cr>

" todo
nmap <silent> <leader>tl :CocList todolist<cr>
nmap <leader>ti :CocCommand todolist.create<cr>
nmap <leader>te :CocCommand todolist.export<cr>
"clear all notifications
nmap <leader>tc :CocCommand todolist.clearNotice<cr>

" coc-smartf, press <esc> to cancel.
nmap f <Plug>(coc-smartf-forward)
nmap F <Plug>(coc-smartf-backward)
nmap <F1> <Plug>(coc-smartf-repeat)
nmap <S-F1> <Plug>(coc-smartf-repeat-opposite)
```
