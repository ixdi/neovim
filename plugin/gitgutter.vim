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
