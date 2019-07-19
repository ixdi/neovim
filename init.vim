let mapleader = ","
let &runtimepath .= "," . $DOTFILES . "/nvim"  " Add DOTFILES to runtimepath
let &packpath .= "," . $DOTFILES . "/nvim"

set shell=zsh                      " Set bash as the prompt for Vim
set backspace=2                    " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile                     " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=200
set ruler                          " show the cursor position all the time
set showcmd                        " display incomplete commands
set laststatus=2                   " Always display the status line
set autowrite                      " Automatically :write before running commands
set noshowmode
set timeoutlen=500
set ttimeoutlen=0
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set scrolloff=3
set list listchars=tab:»·,trail:·  " Display extra whitespace characters
set hidden
set inccommand=nosplit
set nofoldenable                   " disable folding
set gdefault                       " By default add g flag to search/replace. Add g to toggle.
set undodir=~/.config/nvim/undodir
set undofile                       " Maintain undo history between sessions

set mouse=a " Enable moouse in all in all modes.

" Don't show whitespace, since saving will clean it up automatically anyway
set nolist

set foldmethod=indent
set textwidth=0

" Line numbers
set number
set numberwidth=5

" Set spellfile to location that is guaranteed to exist, can be symlinked to
" Dropbox or kept in Git and managed outside of thoughtbot/dotfiles using rcm.
" set spellfile=$HOME/.vim-spell-en.utf-8.add

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright
" Point to the Python executables in `asdf`
"let g:python_host_prog = $ASDF_DIR . '/installs/python/2.7.10/bin/python'
let g:python_host_prog = $ASDF_DIR . '/usr/bin/python2'
"let g:python3_host_prog = $ASDF_DIR . '/installs/python/3.5.0/bin/python'
let g:python3_host_prog = $ASDF_DIR . '/usr/bin/python3'

" Autocommands
if has("autocmd")
  filetype plugin indent on

  autocmd BufReadPost *
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Automatically clean trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e

  autocmd BufRead,BufNewFile *.html set filetype=html.handlebars syntax=mustache
  autocmd BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.prettierrc set filetype=json

endif

" Open current file in Marked
function! MarkedPreview()
  :w
  exec ':silent !open -a "Marked 2.app" ' . shellescape('%:p')
  redraw!
endfunction
nnoremap <leader>md :call MarkedPreview()<CR>
" Open current repo in Tower
function! OpenInGitTower()
  call system('gittower `git rev-parse --show-toplevel`')
endfunction
nnoremap <leader>gt :call OpenInGitTower()<CR>

" Specify plugins
call plug#begin()

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
Plug 'ctrlpvim/ctrlp.vim'                 " easy switch buffers

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

call plug#end()

" Load plugin configurations
" For some reason, a few plugins seem to have config options that cannot be

" Normal Mode Remaps
nnoremap <silence> <F5> :set hlsearch! hlsearch?<CR>

" -- Smart indent when entering insert mode with i on empty lines --------------
function! IndentWithI()
  if len(getline('.')) == 0
    return "\"_ddO"
  else
    return "i"
  endif
endfunction
nnoremap <expr> i IndentWithI()

" Remap the increment and decrement features of Vim
nnoremap <A-a> <C-a>
nnoremap å <C-a>

nnoremap <A-x> <C-x>
nnoremap ≈ <C-x>

set completeopt-=preview

" syntax and color
syntax on
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_ut=                " fix 256 colors in tmux http://sunaku.github.io/vim-256color-bce.html
if has("termguicolors")  " set true colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
set background=dark
colorscheme plastic

if filereadable($DOTFILES . "/nvim/init.local.vim")
  source $DOTFILES/nvim/init.local.vim
endif

" Buffer configuration
nnoremap bp :bprevious<CR>
nnoremap bn :bnext<CR>
nnoremap bd :bdelete<CR>
nnoremap bl :buffers<CR>
nnoremap bds :bufdo bd<CR>

" Exit insert mode
inoremap jj <ESC>

" Fast saving
nmap <leader>w :w!<cr>

" Clear last search (,qs)
map <silent> <leader>m <Esc>:noh<CR>

" Copy/paste between vim instances
vmap <leader>y :w! /tmp/vitmp<CR>
nmap <leader>p :r! cat /tmp/vitmp<CR>

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

"NerdTree
map <F3> :NERDTreeToggle<CR>
"open nerdtree on enter if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close nerdtree if is last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <leader>tf :NERDTreeFind<CR>

" Tabularize
nmap <leader>t :Tabularize /
vmap <leader>t :'<, '>Tabularize /
nmap <leader>T :Tabularize / \zs
vmap <leader>T :'<, '>Tabularize / \zs

" Surround
"insert new chars wrapping word under cursor
nmap <leader>s ysiw
" change char on cursor with new one
nmap <leader>S cs
"cs"' substitute " by '

" Fugitive git
nnoremap <F12> :Gstatus<CR>
nnoremap <F4> :Gcommit<cr>

"CtrlP plugin
nmap <F6> :CtrlPMRU<CR>
" make CtrlP so much faster
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" ctrlsf
nmap <C-F> <Plug>CtrlSFPrompt
vmap <C-F> <Plug>CtrlSFVwordPath
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '30%'
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_default_view_mode = 'compact'

" Indent
"indent command
map <F9> gg=G
" indent from selected bracket
nmap <leader>o <esc>=i}

" Yank from cursor to end of line
nnoremap Y y$

" stripwhitespace
noremap <F7> :StripWhitespace<cr>

" Enable snipMate compatibility feature.
" let g:neosnippet#enable_snipmate_compatibility = 1

" Sort
" map <leader>so :g/{$/+,/^}/-sort<cr>
nnoremap <leader>so vi}:sort<CR>

" Import cost
" map <leader>ic :ImportCost<cr>

" Easymotion
map <Leader>k <Plug>(easymotion-prefix)

" vim doge
let g:doge_mapping = '<leader>D'
let g:doge_mapping_comment_jump_forward = '6'
let g:doge_mapping_comment_jump_backward = '4'

" Comment
map <leader>c <c-_><c-_>

