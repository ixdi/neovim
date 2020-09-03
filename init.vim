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

autocmd BufReadPost,BufNewFile *.html set filetype=handlebars
autocmd BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.prettierrc set filetype=json

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+\%#\@<!$/

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Specify plugins
call plug#begin()

" UI and colors
Plug 'flrnprz/plastic.vim'
Plug 'itchyny/lightline.vim'              " Lightline status bar
" Plug 'mengelbrecht/lightline-bufferline'  " Buffer show for lightline
Plug 'maximbaz/lightline-ale'
Plug 'josa42/vim-lightline-coc'
Plug 'ryanoasis/vim-devicons'             " icons
Plug 'sheerun/vim-polyglot'               " Syntax and indent for different languages

" Project Navigation
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'        " show git changes in nerdtree
Plug 'Yggdroot/indentLine'

" Editing
Plug 'tpope/vim-surround'                 " Change word surroundings
Plug 'tomtom/tcomment_vim'                " Comments
Plug 'alvan/vim-closetag'                 " html autoclose
Plug 'godlygeek/tabular'                  " Tabularize
Plug 'mg979/vim-visual-multi'            " Multiple cursors
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

" move between views
nmap <A-j> <C-w>j
nmap <A-k> <C-w>k
nmap <A-l> <C-w>l
nmap <A-h> <C-w>h
nmap <A-Up> <C-w>_
nmap <A-Right> <C-w>|
nmap <A-Down> <C-w>=

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
nnoremap bda :bufdo bd<CR>

" Exit insert mode
inoremap jj <ESC>

" Clear last search (,qs)
map <silent> <leader>m <Esc>:noh<CR>

" insert new line and set cursor before on insert mode
imap <A-enter> <cr><C-o>O

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
"open nerdtree on enter if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close nerdtree if is last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <leader>f :NERDTreeFind<CR>
let g:NERDTreeWinSize = '35'

"Nerdtree git
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : '☒',
      \ "Unknown"   : "?"
      \ }

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

" vim doge
map <leader>d :DogeGenerate<cr>
let g:doge_mapping_comment_jump_forward = '<A-n>'
let g:doge_mapping_comment_jump_backward = '<A-p>'

let g:doge_doc_standard_python = 'google'

" Comment
map <leader>c <c-_><c-_>

" Mustache
let g:mustache_abbreviations = 1

" lightline
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [
      \   [ 'mode', 'paste'],
      \   [ 'coc_errors', 'coc_warnings' ],
      \   [ 'coc_status'],
      \   [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \ },
      \ }
" let g:lightline.separator = {
" 	\   'left': '', 'right': ''
"   \}

" lightline-buffers
" let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
" let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
" let g:lightline.component_type   = {'buffers': 'tabsel'}

" lightline-coc register compoments:
call lightline#coc#register()

let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#unnamed      = '[No Name]'

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

" Multiple cursors
let g:multi_cursor_exit_from_insert_mode = 1
let g:multi_cursor_exit_from_visual_mode = 1

" Emmet
let g:user_emmet_install_global = 0
" autocmd FileType html,css,html.handlebars EmmetInstall

" Devicons
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_ctrlp = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 0
let g:WebDevIconsOS = 'Darwin'

" Coc configurations
imap <C-e> <Plug>(coc-snippets-expand)

nmap <F5> <esc>:CocList -A --normal yank<cr>
nmap <F6> <esc>:CocList --number-select tags<cr>
nmap <C-p> <esc>:CocList --number-select --normal mru<cr>
nmap <F8> <esc>:CocList --number-select buffers<cr>
nmap <F9> <esc>:CocList --number-select files<cr>
nmap <F10> <esc>:CocUpdate<cr>
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
nmap <silent> <leader>di <Plug>(coc-implementation)
" coc eslint errors keymappings
nmap <silent> <leader>ep <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>en <Plug>(coc-diagnostic-next)

" Use tab for trigger completion with characters ahead and navigate.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ \s''
endfunction'

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible( ? )\"C-p><" : "\<S-Tab">>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR">"
" make <cr> select the first completion item and confirm the completion when no item has been selected
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '•'

" Controls annotations (cheat)
" <C-o> go to last opened buffer
" <leader>1 to 3 to set different layouts

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

augroup Smartf
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#a890F0
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#b09f96
augroup end
