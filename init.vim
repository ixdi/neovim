" terminal font: nerd-jetbrains-mono
let mapleader = ","
let &runtimepath .= "," . $DOTFILES . "/nvim"  " Add DOTFILES to runtimepath
let &packpath .= "," . $DOTFILES . "/nvim"

set autowrite                      " Automatically :write before running commands
set backspace=2                    " Backspace deletes like most programs in insert mode
set conceallevel=0                 " Text like " is shown normally
set expandtab
set foldmethod=indent
set gdefault                       " By default add g flag to search/replace. Add g to toggle.
set hidden
set history=200
set inccommand=nosplit
set laststatus=2                   " Always display the status line
set list listchars=tab:»·,trail:·  " Display extra whitespace characters
set mouse=a                        " Enable mouse in all in all modes.
set nobackup
set nofoldenable                   " Disable folding
set nolist                         " Don't show whitespace, since saving will clean it up automatically anyway
set noshowmode
set noswapfile                     " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set nowritebackup
set ruler                          " Show the cursor position all the time
set scrolloff=3
set shell=zsh                      " Set bash as the prompt for Vim
set shiftround
set shiftwidth=2
set showcmd                        " Display incomplete commands
" set smartindent
set cindent
set tabstop=2
set textwidth=120
set timeoutlen=500
set ttimeoutlen=0
set undodir=~/.config/nvim/undodir
set undofile                       " Maintain undo history between sessions

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
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

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
" Mark extra whitespace as red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+\%#\@<!$/

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" polyglot, need to be called before plugin load
let g:polyglot_disabled = ['html5']

" Specify plugins
call plug#begin()

" Project Navigation
Plug 'preservim/nerdtree'                 " file explorer
Plug 'Xuyuanp/nerdtree-git-plugin'        " show git changes in nerdtree
Plug 'Yggdroot/indentLine'                " show vertical lines in indented code

" Editing
Plug 'tpope/vim-surround'                 " Change word surroundings
Plug 'tomtom/tcomment_vim'                " Comments
Plug 'alvan/vim-closetag'                 " html autoclose
Plug 'godlygeek/tabular'                  " Tabularize
Plug 'mg979/vim-visual-multi'             " Multiple cursors
Plug 'mattn/emmet-vim'                    " Emmet
Plug 'wellle/targets.vim'                 " More text objects to operate on
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " View markdown document while editing

" Git
Plug 'tpope/vim-fugitive'                 " Git stuff in Vim

" COC is the base platform for multiple features!
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" Autocomplete
Plug 'ixdi/vim-meteor-snippets'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }  " Generate jsDoc
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" Language Support
Plug 'mustache/vim-mustache-handlebars'   " Handlebars and spacebars

" UI and colors
Plug 'itchyny/lightline.vim'              " Lightline status bar
Plug 'maximbaz/lightline-ale'             " show errors in statusline
Plug 'josa42/vim-lightline-coc'           " show coc state in statusline
Plug 'EdenEast/nightfox.nvim' " Vim-Plug

" Plug 'rakr/vim-one'
Plug 'ryanoasis/vim-devicons'             " icons
Plug 'frazrepo/vim-rainbow'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" Load plugin configurations

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

" " move between views using Alt instead of Ctrl
" nnoremap <silent> <A-j> <C-w>j
" nnoremap <silent> <A-k> <C-w>k
" nnoremap <silent> <A-l> <C-w>l
" nnoremap <silent> <A-h> <C-w>h
" nnoremap <silent> <A-H> <C-w>_
" nnoremap <silent> <A-L> <C-w>|
" nnoremap <silent> <A-J> <C-w>=

" syntax and color
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set t_ut=                " fix 256 colors in tmux http://sunaku.github.io/vim-256color-bce.html
if (has("termguicolors"))  " set true colors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
  " set notermguicolors
endif
set background=dark
let g:one_allow_italics = 1 " italic for comments
colorscheme nordfox

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
imap <silent> <A-enter> <cr><C-o>O

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
map <silent><special> <space>e :NERDTreeToggle<CR>
map <silent><special> <F3> :NERDTreeToggle<CR>
nmap <silent> <leader>f :NERDTreeFind<CR>
"open nerdtree on enter if no file specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close nerdtree if is last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeWinSize = '45'

"Nerdtree git
let g:NERDTreeGitStatusIndicatorMapCustom = {
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

" NERDTrees File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('jade', 'LightGreen', 'none', 'LightGreen', 'none')
call NERDTreeHighlightFile('ini', 'LightYellow', 'none', 'LightYellow', 'none')
call NERDTreeHighlightFile('md', 'LightMagenta', 'none', 'LightMagenta', 'none')
call NERDTreeHighlightFile('config', 'LightYellow', 'none', 'LightYellow', 'none')
call NERDTreeHighlightFile('conf', 'LightYellow', 'none', 'LightYellow', 'none')
call NERDTreeHighlightFile('json', 'LightMagenta', 'none', 'LightMagenta', 'none')
call NERDTreeHighlightFile('yaml', 'LightMagenta', 'none', 'LightMagenta', 'none')
call NERDTreeHighlightFile('html', 'cyan', 'none', 'cyan', 'none')
call NERDTreeHighlightFile('styl', 'LightGreen', 'none', 'LightGreen', 'none')
call NERDTreeHighlightFile('css', 'LightGreen', 'none', 'LightGreen', 'none')
call NERDTreeHighlightFile('coffee', 'red', 'none', 'red', 'none')
call NERDTreeHighlightFile('js', 'LightYellow', 'none', 'LightYellow', 'none')
call NERDTreeHighlightFile('py', 'LightYellow', 'none', 'LightYellow', 'none')
call NERDTreeHighlightFile('php', 'LightMagenta', 'none', 'LightMagenta', 'none')
call NERDTreeHighlightFile('txt', 'LightGray', 'none', 'LightGray', 'none')
call NERDTreeHighlightFile('pem', 'black', 'none', 'black', 'none')
call NERDTreeHighlightFile('vim', 'white', 'none', 'white', 'none')
call NERDTreeHighlightFile('ds_store', 'LightGray', 'none', '#686868', 'none')
call NERDTreeHighlightFile('gitconfig', 'LightGray', 'none', '#686868', 'none')
call NERDTreeHighlightFile('gitignore', 'LightGray', 'none', '#686868', 'none')
call NERDTreeHighlightFile('bashrc', 'LightGray', 'none', '#686868', 'none')
call NERDTreeHighlightFile('bashprofile', 'LightGray', 'none', '#686868', 'none')

"nore Tabularize
noremap <leader>t :Tabularize /
vnoremap <leader>t :'<, '>Tabularize /
noremap <leader>T :Tabularize / \zs
vnoremap <leader>T :'<, '>Tabularize / \zs

" Surround
" change char on cursor with new one, cs"' substitute " by '
nmap <silent> <leader>sc <esc>cs
" replace tag for anotherone
nmap <silent> <leader>st <esc>cstt
"insert new chars wrapping word under cursor
nmap <silent> <leader>s <esc>ysiw

" Fugitive git
nmap <silent> <leader>g :Git<CR>
nmap <silent> <leader>gc :Git commit<cr>

" Indent
" select all file and indent
noremap <silent> <leader>o <esc>gg=G<C-o>
" indent bracket
noremap <silent> <leader>oo <esc>=i}

" stripwhitespace
noremap <silent><special> <F7> :%s/\s\+$//e<cr>

" Sort blocks
nnoremap <silent> <leader>so vi}:sort<CR>

" Import cost
" map <leader>ic :ImportCost<cr>

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

" set updatetime=1000
" noremap <leader>g :GitGutterToggle<cr>
" noremap <leader>gn <Plug>GitGutterNextHunk
" noremap <leader>gp <Plug>GitGutterPrevHunk
" highlight link GitGutterChangeLine DiffText
" highlight GitGutterAdd    guifg=#009900 guibg=#222233 ctermfg=2 ctermbg=0
" highlight GitGutterChange guifg=#bbbb00 guibg=#222233 ctermfg=3 ctermbg=0
" highlight GitGutterDelete guifg=#ff2222 guibg=#222233 ctermfg=1 ctermbg=0
" let g:gitgutter_enabled = 0

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>r :e<cr>

" Multiple cursors

let g:multi_cursor_exit_from_insert_mode = 1
let g:multi_cursor_exit_from_visual_mode = 1

" Emmet
let g:user_emmet_install_global = 0

" Devicons
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_ctrlp = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsOS = 'Darwin'
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" Coc configurations
" ==================

" Coc snippets
imap <C-e> <Plug>(coc-snippets-expand)
" Select text for visual placeholder of snippet.
vmap <C-s> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
" Coc lists
noremap <C-l> <esc>:CocListResume<cr>
noremap <C-f> <esc>:CocList grep<cr>
" search for yank
nnoremap <silent> <space>y :<C-u>CocList --number-select yank<cr>
" search for files
nnoremap <silent> <space>f :<C-u>CocList --number-select files<cr>
" search for most recently used
nnoremap <silent> <space>u :<C-u>CocList --number-select mru<cr>
nnoremap <silent> <space>di :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
" show symbols of the current document
nnoremap <silent> <space>o :<C-u>CocList --number-select outline<cr>
" search workspace symbols
nnoremap <silent> <space>s :<C-u>CocList --number-select -I symbols<cr>
" Git
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>
" default actions to prev or next item
nnoremap <silent> <space>j :<C-u>CocList CocNext<cr>
nnoremap <silent> <space>k :<C-u>CocList CocPrev<cr>

" goto definitions
nnoremap <silent> <space>d <Plug>(coc-definition)
nmap <leader>dd <Plug>(coc-definition)
nnoremap <silent> <space>r <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-references)
nnoremap <silent> <space>i <Plug>(coc-implementation)
nmap <leader>ii <Plug>(coc-implementation)
" coc eslint errors keymappings
nmap <leader>ep <Plug>(coc-diagnostic-prev)
nmap <leader>e <Plug>(coc-diagnostic-next)
" view documentation of the symbol under the cursor
nnoremap <silent> <space>h :call CocActionAsync('doHover')<cr>

" Show documentation when K is pushed
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Highlight the symbol under cursor when holding on it
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Use to rewrite a function inside (cif) or around (caf)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use tab to range select the block where cursor is in
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" use :OR to organize the imports
command! -nargs=0 OR :call CocActionAsync('runCommand','editor.action.organizeImport')

let g:coc_status_error_sign = '•'
let g:coc_status_warning_sign = '*'

"tags
nmap <leader>tg <C-]>
nmap <leader>tt <C-t>

"session
noremap <leader>ssave :CocCommand session.save<cr>
noremap <leader>sload :CocCommand session.load<cr>

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
nnoremap <silent> <space>m <Plug>MarkdownPreviewToggle

" Pangloss JS syntax heighlight
" Enable JSDoc highlighting
let g:javascript_plugin_jsdoc = 1
" JavaScript Concealing
" let g:javascript_conceal = 0
" let g:javascript_conceal_function       = "ƒ"
" let g:javascript_conceal_null           = "ø"
" let g:javascript_conceal_this           = "@"
" let g:javascript_conceal_return         = "⇚"
" let g:javascript_conceal_undefined      = "¿"
" let g:javascript_conceal_NaN            = "ℕ"
" let g:javascript_conceal_prototype      = "¶"
" let g:javascript_conceal_static         = "•"
" let g:javascript_conceal_super          = "Ω"
" let g:javascript_conceal_arrow_function = "⇒"

" Rainbow, improves parenthesis
au FileType js,javascript call rainbow#load()

" indentLine (forces conceallevel to 2 every time so fix it)
let g:indentLine_setConceal = 0

" vim doge
" map <leader>d :DogeGenerate<cr>
let g:doge_mapping = '<leader>d'
let g:doge_comment_interactive = 1
let g:doge_mapping_comment_jump_forward = '<leader>n'
let g:doge_mapping_comment_jump_backward = '<A-p>'
let g:doge_doc_standard_python = 'sphinx'

" pydocstring
nmap <silent> <leader>dd <Plug>(pydocstring)
" sphinx, google or numpy
let g:pydocstring_formatter = 'sphinx'

" Install all coc-extensions
let g:coc_global_extensions = [
            \ 'coc-yank',
            \ 'coc-stylelintplus',
            \ 'coc-snippets',
            \ 'coc-smartf',
            \ 'coc-prettier',
            \ 'coc-pairs',
            \ 'coc-marketplace',
            \ 'coc-lists',
            \ 'coc-html',
            \ 'coc-highlight',
            \ 'coc-git',
            \ 'coc-eslint',
            \ 'coc-emmet',
            \ 'coc-yaml',
            \ 'coc-tsserver',
            \ 'coc-pyright',
            \ 'coc-markdownlint',
            \ 'coc-json',
            \ 'coc-css',
            \ ]

:source /home/scortes/.config/nvim/lua/init.lua

autocmd BufWritePre *.ts,*.js :call CocAction('runCommand', 'tsserver.organizeImports')

" use TAB for the new coc popover window
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ "\<Tab>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
