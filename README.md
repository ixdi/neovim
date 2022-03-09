# Neovim

Config files for my neovim. See COC Project at https://github.com/neoclide/coc.nvim

Clone the repo to ```~/.config/nvim```

## Installation

Install ```nodejs``` required by Coc plugin

Install ```ripgrep``` command line utility (used by coc) https://github.com/BurntSushi/ripgrep

Install ```ctags``` command line

Install ```junegunn/vim-plug``` to manage plugins
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then run ```:PlugUpgrade``` to update vim-plug and ```:PlugUpdate``` to update all plugins

Finally install specific COC plugins
```vim
:CocInstall coc-yank coc-tsserver coc-snippets coc-stylelintplus coc-smartf coc-marketplace coc-prettier coc-pairs coc-lists coc-json coc-html coc-highlight coc-eslint coc-css coc-pyright coc-emmet coc-yaml coc-git coc-markdownlint
```

## Plugins

```vim
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

## Shortcuts

```vim
let mapleader = ","

" Exit insert mode
jj

" Fast saving
<leader>w :w!<cr>

" History search
<silence> <F5> :set hlsearch! hlsearch?<CR>

" Remap the increment and decrement features of Vim
<A-a> <C-a>
<A-x> <C-x>

" move between views using Alt instead of Ctrl
<A-j> <C-w>j
<A-k> <C-w>kcoc-yank 1.2.1 ~/.config/coc/extensions/node_modules/coc-yank
<A-l> <C-w>l
<A-h> <C-w>h
<A-Up> <C-w>_
<A-Right> <C-w>|
<A-Down> <C-w>=

" Buffer configuration
bp :bprevious<CR>
bn :bnext<CR>
bd :bdelete<CR>
bl :buffers<CR>
bda :bufdo bd<CR>

" Copy/paste between vim instances
<leader>y "*y
<leader>p "*p
p ]p
P ]P

" set handlebars file type
<leader>h :set filetype=handlebars<cr>

" Search and replace word under cursor (,*)
<leader>* :%s/\<<C-r><C-w>\>//<Left>

"NerdTree
<F3> :NERDTreeToggle<CR>
" find current file in NerdTree
<silent> <leader>f :NERDTreeFind<CR>

" Tabularize
<leader>t :Tabularize /
<leader>t :'<, '>Tabularize /
<leader>T :Tabularize / \zs
<leader>T :'<, '>Tabularize / \zs

" Surround
" change char on cursor with new one, cs"' substitute " by '
<leader>s <esc>cs
" replace tag for anotherone
<leader>st <esc>cstt
"insert new chars wrapping word under cursor
<leader>sw <esc>ysiw

" Fugitive git
<F12> :Gstatus<CR>
<F4> :Gcommit<cr>

" Indent
" select all file and indent
<leader>o <esc>gg=G<C-o>
" indent bracket
<leader>oo <esc>=i}

" stripwhitespace
<F7> :%s/\s\+$//e<cr>

" Sort css
<leader>so vi}:sort<CR>

" Import cost
<leader>ic :ImportCost<cr>

" vim doge code comment autocompletion
<leader>d :DogeGenerate<cr>

" Comment lines
<leader>c <c-_><c-_>

" Lists configurations
<C-e> <Plug>(coc-snippets-expand)
" Coc lists
<C-l> <esc>:CocListResume<cr>
<C-f> <esc>:CocList grep<cr>
" search for yank
<silent> <space>y :<C-u>CocList --number-select yank<cr>
" search for files
<silent> <space>f :<C-u>CocList --number-select files<cr>
" search for most recently used
<silent> <space>u :<C-u>CocList --number-select mru<cr>
<silent> <space>e :<C-u>CocList diagnostics<cr>
<silent> <space>c :<C-u>CocList commands<cr>
" show symbols of the current document
<silent> <space>o :<C-u>CocList --number-select outline<cr>
" search workspace symbols
<silent> <space>s :<C-u>CocList --number-select -I symbols<cr>
" default actions to prev or next item
<silent> <space>j :<C-u>CocList CocNext<cr>
<silent> <space>k :<C-u>CocList CocPrev<cr>

" goto definitions
<leader>dd <Plug>(coc-definition)
<leader>dr <Plug>(coc-references)
<leader>di <Plug>(coc-implementation)
" coc eslint errors keymappings
<leader>ep <Plug>(coc-diagnostic-prev)
<leader>e <Plug>(coc-diagnostic-next)

" Show documentation when K is pushed
<silent> K :call CocAction('doHover')<CR>

" Highlight the symbol under cursor when holding on it
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
<leader>rn <Plug>(coc-rename)

" Use to rewrite a function inside (cif) or around (caf)
if <Plug>(coc-funcobj-i)
af <Plug>(coc-funcobj-a)

" Use tab to range select the block where cursor is in
<silent> <TAB> <Plug>(coc-range-select)

" use :OR to organize the imports
command! -nargs=0 OR :call CocAction('runCommand','editor.action.organizeImport')

" Keymapping for grep word under cursor with interactive mode
<silent> <leader>vf :exe 'CocList --normal --input='.expand('<cword>').' grep'<cr>

" goto definitions
<silent> <leader>dd <Plug>(coc-definition)
<silent> <leader>dr <Plug>(coc-references)
<silent> <leader>di <Plug>(coc-implementation)
" coc eslint errors keymappings
<silent> <leader>ep <Plug>(coc-diagnostic-prev)
<silent> <leader>en <Plug>(coc-diagnostic-next)

"tags
<leader>t <C-]>
<leader>tt <C-t>

"session
<silent> <leader>ss :CocCommand session.save<cr>
<silent> <leader>sl :CocCommand session.load<cr>

" todo
<silent> <leader>tl :CocList todolist<cr>
<leader>ti :CocCommand todolist.create<cr>
<leader>te :CocCommand todolist.export<cr>

"clear all notifications
<leader>tc :CocCommand todolist.clearNotice<cr>

" coc-smartf, press <esc> to cancel.
f <Plug>(coc-smartf-forward)
F <Plug>(coc-smartf-backward)

" Markdown preview
<C-m>p <Plug>MarkdownPreview
<C-m>s <Plug>MarkdownPreviewStop
<C-m> <Plug>MarkdownPreviewToggle
```
