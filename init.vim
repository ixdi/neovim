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

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+\%#\@<!$/

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" polyglot, need to be called before plugin load
let g:polyglot_disabled = ['html5']

" Specify plugins
call plug#begin()

" UI and colors
Plug 'flrnprz/plastic.vim'
Plug 'itchyny/lightline.vim'              " Lightline status bar
" Plug 'mengelbrecht/lightline-bufferline'  " Buffer show for lightline
Plug 'maximbaz/lightline-ale'             " show errors in statusline
Plug 'josa42/vim-lightline-coc'           " show coc state in statusline
Plug 'ryanoasis/vim-devicons'             " icons
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
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " View markdown document while editing

" Git
Plug 'tpope/vim-fugitive'                 " Git stuff in Vim
Plug 'airblade/vim-gitgutter'             " Git show changes

" Task Running
" Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }

" COC is the base platform for multiple features!
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Autocomplete
Plug 'ixdi/vim-meteor-snippets'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }  " Generate jsDoc

" Language Support
Plug 'othree/html5.vim'
" Plug 'sheerun/vim-polyglot'               " Syntax and indent for different languages
Plug 'cakebaker/scss-syntax.vim'
Plug 'elzr/vim-json'
Plug 'mustache/vim-mustache-handlebars'   " Handlebars and spacebars
Plug 'pangloss/vim-javascript'

call plug#end()

" Load plugin configurations
" For some reason, a few plugins seem to have config options that cannot be

" History search
nnoremap <silent> <F5> :set hlsearch! hlsearch?<CR>

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
nnoremap <silent> <A-a> <C-a>
nnoremap <silent> <A-x> <C-x>

set completeopt-=preview

" move between views using Alt instead of Ctrl
nnoremap <silent> <A-j> <C-w>j
nnoremap <silent> <A-k> <C-w>k
nnoremap <silent> <A-l> <C-w>l
nnoremap <silent> <A-h> <C-w>h
nnoremap <silent> <A-Up> <C-w>_
nnoremap <silent> <A-Right> <C-w>|
nnoremap <silent> <A-Down> <C-w>=

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
inoremap <silent> jj <ESC>

" Clear last search (,qs)
map <silent> <leader>m <Esc>:noh<CR>

" insert new line and set cursor before on insert mode
imap <A-enter> <cr><C-o>O

" Copy/paste between vim instances
vmap <silent> <leader>y "*y
nmap <silent> <leader>p "*p
nmap <silent> p ]p
nmap <silent> P ]P

" set handlebars file type
nmap <leader>h :set filetype=handlebars<cr>

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

"NerdTree
map <silent><special> <F3> :NERDTreeToggle<CR>
"open nerdtree on enter if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close nerdtree if is last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <silent> <leader>f :NERDTreeFind<CR>
let g:NERDTreeWinSize = '45'

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

"nore Tabularize
noremap <leader>t :Tabularize /
vnoremap <leader>t :'<, '>Tabularize /
noremap <leader>T :Tabularize / \zs
vnoremap <leader>T :'<, '>Tabularize / \zs

" Surround
" change char on cursor with new one, cs"' substitute " by '
nmap <silent> <leader>s <esc>cs
" replace tag for anotherone
nmap <silent> <leader>st <esc>cstt
"insert new chars wrapping word under cursor
nmap <silent> <leader>sw <esc>ysiw

" Fugitive git
nnoremap <special> <F12> :Gstatus<CR>
nnoremap <special> <F4> :Gcommit<cr>

" Indent
" select all file and indent
noremap <silent> <leader>o <esc>gg=G<C-o>
" indent bracket
noremap <silent> <leader>oo <esc>=i}

" stripwhitespace
noremap <silent><special> <F7> :%s/\s\+$//e<cr>

" Sort css
nnoremap <silent> <leader>so vi}:sort<CR>

" Import cost
" map <leader>ic :ImportCost<cr>

" vim doge
" map <leader>d :DogeGenerate<cr>
let g:doge_mapping = '<Leader>d'
let g:doge_mapping_comment_jump_forward = '<A-n>'
let g:doge_mapping_comment_jump_backward = '<A-p>'

let g:doge_doc_standard_python = 'google'

" Comment
map <silent> <leader>c <c-_><c-_>

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
noremap <leader>g :GitGutterToggle<cr>
noremap <leader>gn <Plug>GitGutterNextHunk
noremap <leader>gp <Plug>GitGutterPrevHunk
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

noremap <special> <F5> <esc>:CocList -A --normal yank<cr>
noremap <special> <F6> <esc>:CocList --number-select tags<cr>
noremap <special> <C-p> <esc>:CocList --number-select --normal mru<cr>
noremap <special> <F8> <esc>:CocList --number-select buffers<cr>
noremap <special> <F9> <esc>:CocList --number-select files<cr>
noremap <special> <F10> <esc>:CocUpdate<cr>
noremap <C-l> <esc>:CocListResume<cr>
noremap <C-f> <esc>:CocList grep<cr>
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
nmap <leader>dd <Plug>(coc-definition)
nmap <leader>dr <Plug>(coc-references)
nmap <leader>di <Plug>(coc-implementation)
" coc eslint errors keymappings
nmap <leader>ep <Plug>(coc-diagnostic-prev)
nmap <leader>e <Plug>(coc-diagnostic-next)

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
nmap <leader>tg <C-]>
nmap <leader>tt <C-t>

"session
noremap <leader>ss :CocCommand session.save<cr>
noremap <leader>sl :CocCommand session.load<cr>

" todo
noremap <leader>tl :CocList todolist<cr>
noremap <leader>ti :CocCommand todolist.create<cr>
noremap <leader>te :CocCommand todolist.export<cr>
"clear all notifications
noremap <leader>tc :CocCommand todolist.clearNotice<cr>

" coc-smartf, press <esc> to cancel.
nmap f <Plug>(coc-smartf-forward)
nmap F <Plug>(coc-smartf-backward)
nmap <special> <F1> <Plug>(coc-smartf-repeat)
nmap <special> <S-F1> <Plug>(coc-smartf-repeat-opposite)

augroup Smartf
  autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#a890F0
  autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#b09f96
augroup end

" autoload
au BufReadPost,BufNewFile *.html set filetype=handlebars
au BufRead,BufNewFile .eslintrc,.jscsrc,.jshintrc,.babelrc,.prettierrc set filetype=json
au BufRead,BufNewFile *.scss set filetype=scss.css

" Markdown preview
nmap <C-m>p <Plug>MarkdownPreview
nmap <C-m>s <Plug>MarkdownPreviewStop
nmap <C-m> <Plug>MarkdownPreviewToggle
