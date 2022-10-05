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

" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Specify plugins
call plug#begin()

" Project Navigation

" Editing
Plug 'godlygeek/tabular'                  " Tabularize
Plug 'mg979/vim-visual-multi'             " Multiple cursors
Plug 'mattn/emmet-vim'                    " Emmet
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  } " View markdown document while editing

" COC is the base platform for multiple features!
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

" Autocomplete
Plug 'ixdi/vim-meteor-snippets'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }  " Generate jsDoc
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

" Language Support
Plug 'mustache/vim-mustache-handlebars'   " Handlebars and spacebars

" Neovim LUA
" Some references here: https://jdhao.github.io/nvim-config/
Plug 'nvim-lualine/lualine.nvim' " Statusline using lua
Plug 'EdenEast/nightfox.nvim' " lua theme using treesitter
Plug 'kyazdani42/nvim-web-devicons' " icons using lua
Plug 'kyazdani42/nvim-tree.lua' " replace for nerdtree in lua
Plug 'p00f/nvim-ts-rainbow' " colorize closing brackets
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " make a tree of relations. Used by some plugins
Plug 'liuchengxu/vista.vim' " View the code symbols references using lua
Plug 'RRethy/vim-illuminate' " Highlight identical words using lua
Plug 'phaazon/hop.nvim' " Jump quickly to a certaing part of the code using lua
Plug 'numToStr/Comment.nvim' " Comments using lua
Plug 'windwp/nvim-autopairs' " autopairs using lua and treesitter
Plug 'windwp/nvim-ts-autotag' " Close tags using lua and treesitter
Plug 'gbprod/yanky.nvim' " extended yank using lua
Plug 'nvim-lua/plenary.nvim' " lua functions I don't want to write twice
Plug 'folke/todo-comments.nvim' " to highlight todo sections
Plug 'kylechui/nvim-surround' " replace pair chars using lua
Plug 'lewis6991/gitsigns.nvim' " Git integration using lua
Plug 'karb94/neoscroll.nvim' " smooth scroll

call plug#end()

" Load plugin configurations

" History search
nnoremap <silent> <F5> :set hlsearch! hlsearch?<CR>

set completeopt-=preview

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

" set handlebars file type
nmap <leader>h :set filetype=handlebars<cr>

" Search and replace word under cursor (,*)
nnoremap <leader>* :%s/\<<C-r><C-w>\>//<Left>

" Neovim tree using lua
map <silent><special> <space>e :NvimTreeToggle<CR>
map <silent><special> <F3> :NvimTreeToggle<CR>
nmap <silent> <leader>f :NvimTreeFindFile<CR>

"nore Tabularize
noremap <leader>t :Tabularize /
vnoremap <leader>t :'<, '>Tabularize /
noremap <leader>T :Tabularize / \zs
vnoremap <leader>T :'<, '>Tabularize / \zs

" Surround
" change char on cursor with new one, cs"' substitute " by '
nmap <silent> <leader>sc <esc>cs
" replace tag for anotherone
nmap <silent> <leader>st <esc>cst
"insert new chars wrapping word under cursor
nmap <silent> <leader>s <esc>ysiw
"delete around. Using dst will remove the enclosing tag
nmap <silent> <leader>ds <esc>ds

" Fugitive git
nmap <silent> <leader>g :Gitsigns preview_hunk<CR>

" Indent
" select all file and indent
noremap <silent> <leader>o <esc>gg=G<C-o>
" indent bracket
noremap <silent> <leader>oo <esc>=i}

" stripwhitespace
noremap <silent><special> <F7> :%s/\s\+$//e<cr>

" Sort blocks
nnoremap <silent> <leader>so vi}:sort<CR>

" Comment
map <silent> <leader>c gcc

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>r :e<cr>

" Multiple cursors
let g:multi_cursor_exit_from_insert_mode = 1
let g:multi_cursor_exit_from_visual_mode = 1

" Emmet
let g:user_emmet_install_global = 0

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
" Git
nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>
" default actions to prev or next item
nnoremap <silent> <space>j :<C-u>CocList CocNext<cr>
nnoremap <silent> <space>k :<C-u>CocList CocPrev<cr>

" goto definitions
nnoremap <silent> <space>d <Plug>(coc-definition)
nnoremap <silent> <space>r <Plug>(coc-references)
nnoremap <silent> <space>i <Plug>(coc-implementation)
" coc eslint errors keymappings
nmap <leader>ep <Plug>(coc-diagnostic-prev)
nmap <leader>e <Plug>(coc-diagnostic-next)
" view documentation of the symbol under the cursor
nnoremap <silent> <space>h :call CocActionAsync('doHover')<cr>

" Show documentation when K is pushed
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Use to rewrite a function inside (cif) or around (caf)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use tab to range select the block where cursor is in
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" organize imports when saving
autocmd BufWritePre *.ts,*.js :call CocAction('runCommand', 'tsserver.organizeImports')

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

" use TAB for the new coc popover window
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ "\<Tab>"
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

" LUA configs
lua require('init')

nnoremap <silent> <space>t :TodoQuickFix<cr>

" Illuminate word under cursor
nnoremap <silent> <space>l :IlluminateToggle<cr>

" view symbols
nnoremap <silent> <space>s :Vista!!<cr>
" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Hop to jump quickly
nnoremap <silent> s :HopPattern<cr>
nnoremap <silent> <space>h :HopWord<cr>
nnoremap <silent> <space>h1 :HopChar1<cr>
nnoremap <silent> <space>h2 :HopChar2<cr>
nnoremap <silent> <space>hl :HopLine<cr>
