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

if has("autocmd")
  " Autocommands
  filetype plugin indent on

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

  autocmd BufRead,BufNewFile *.html set filetype=html.handlebars syntax=mustache
  autocmd BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.prettierrc set filetype=json

  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd InsertLeave * match ExtraWhitespace /\s\+\%#\@<!$/

endif

" Specify plugins
call plug#begin()

" UI and colors
Plug 'flrnprz/plastic.vim'
Plug 'vim-airline/vim-airline'            " Handy info
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
nnoremap <A-x> <C-x>

set completeopt-=preview

" syntax and color
syntax on
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_ut=                " fix 256 colors in tmux http://sunaku.github.io/vim-256color-bce.html
if (has("termguicolors"))  " set true colors
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
nmap <leader>f :NERDTreeFind<CR>
let g:NERDTreeWinSize = '35'

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
nmap <leader>sl <esc>ysiw
" S<tag> will wrap visual selected text with <tag>

" Fugitive git
nnoremap <F12> :Gstatus<CR>
nnoremap <F4> :Gcommit<cr>

" Indent
" select all file and indent
nmap <leader>o <esc>ggVG=
" indent bracket
nmap <leader>oo <esc>=i}

" stripwhitespace
noremap <F7> :%s/\s\+$//e<cr>

" Sort css
nnoremap <leader>so vi}:sort<CR>

" Import cost
" map <leader>ic :ImportCost<cr>

" Easymotion
map <Leader>k <Plug>(easymotion-prefix)

" vim doge
map <Leader>d :DogeGenerate<cr>
" let g:doge_mapping = '<leader>D'
let g:doge_mapping_comment_jump_forward = 'n'
let g:doge_mapping_comment_jump_backward = 'p'

" Comment
map <leader>c <c-_><c-_>

" Mustache
let g:mustache_abbreviations = 1

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0

let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#neomake#enabled = 0
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts = 1 " Enable the patched Powerline fonts
let g:airline#extensions#coc#enabled = 1
" let g:airline_theme='plastic'

" Gitgutter
cnoreabbrev Gundo GitGutterUndoHunk

let g:gitgutter_max_signs = 3500  " default value

set updatetime=1000
map <leader>g :GitGutterToggle<cr>
nmap <leader>gn <Plug>GitGutterNextHunk
nmap <leader>gp <Plug>GitGutterPrevHunk
highlight link GitGutterChangeLine DiffText
highlight GitGutterAdd    guifg=#009900 guibg=#222233 ctermfg=2 ctermbg=0
highlight GitGutterChange guifg=#bbbb00 guibg=#222233 ctermfg=3 ctermbg=0
highlight GitGutterDelete guifg=#ff2222 guibg=#222233 ctermfg=1 ctermbg=0
let g:gitgutter_enabled = 0

" Fast saving
nmap <leader>w :w!<cr>

" Coc configurations
imap <C-e> <Plug>(coc-snippets-expand)  " snippets expand
nmap <silent> <C-c> <Plug>(coc-cursors-position)

nmap <F6> <esc>:CocList --number-select --normal mru<cr>
nmap <C-p> <esc>:CocList --number-select --normal mru<cr>
nmap <F8> <esc>:CocList --number-select buffers<cr>
nmap <F9> <esc>:CocList --number-select files<cr>
nmap <F10> <esc>:CocListResume<cr>
nmap <C-l> <esc>:CocListResume<cr>
nmap <C-f> <esc>:CocList grep<cr>
" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep'.<q-args>

function! s:GrepArgs(...)
  let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
        \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
  return join(list, "\n")
endfunction

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <leader>vf :exe 'CocList --normal --input='.expand('<cword>').' grep'<cr>

" goto definitions
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)

nnoremap <silent> <space>y  :<C-u>CocList --normal yank<cr>
