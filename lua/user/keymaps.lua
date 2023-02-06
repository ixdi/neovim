-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = {silent = true}

-- Remap , as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- History search
keymap("n", "<F5>", ":set hlsearch! hlsearch?<cr>", opts)

-- Buffer configuration
keymap("n", "bp", ":bprevious<cr>", opts)
keymap("n", "bn", ":bnext<cr>", opts)
keymap("n", "bd", ":bdelete<cr>", opts)
keymap("n", "bl", ":buffers<cr>", opts)
keymap("n", "bda", ":%bd|e#|bd#<cr>", opts) -- closes all except current one and remove noName

-- Clear last search (,qs)
keymap("n", "<leader>m", ":noh<cr>", opts)

-- set handlebars file type
keymap("n", "<leader>h", ":set filetype=mustache<cr>", opts)

-- Search and replace word under cursor (,*)
-- keymap("n", "<leader>*", ":%s/\<C-r><C-w>\>//<Left>", opts)

-- select word under cursor
keymap("n", "<leader>s", "<esc>viw", opts)

-- Indent
-- select all file and indent
keymap("n", "<leader>i", "<esc>gg=G", opts)
-- indent bracket
keymap("n", "<leader>ii", "<esc>=i", opts)

-- stripwhitespace
keymap("n", "<F7>", ":%s/s+$//e<cr>", opts)

-- Sort blocks
keymap("n", "<leader>so", "vi}:sort<cr>", opts)

-- Fast saving
keymap("n", "<leader>w", ":w<cr>", opts)
keymap("n", "<leader>ww", ":noa w<cr>", opts)
keymap("n", "<leader>r", ":e<cr>", opts)

-- Markdown preview
keymap("n", "<space>m", "<Plug>MarkdownPreviewToggle", opts)

-- tree using lua
keymap("n", "<space>e", ":NvimTreeToggle<cr>", opts)
keymap("n", "<leader>f", ":NvimTreeFindFile<cr>", opts)

keymap("n", "<space>t", ":TodoTelescope<cr>", opts)

-- Illuminate word under cursor
keymap("n", "<space>l", ":IlluminateToggle<cr>", opts)

-- Comment
keymap("n", "<leader>c",
       "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("v", "<leader>c",
       '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<cr>')

-- Hop to jump quickly
keymap("n", "s", ":HopPattern<cr>", opts)
keymap("n", "<space>hw", ":HopWord<cr>", opts)
keymap("n", "<space>h1", ":HopChar1<cr>", opts)
keymap("n", "<space>h2", ":HopChar2<cr>", opts)
keymap("n", "<space>hl", ":HopLine<cr>", opts)

-- Telescope
keymap("n", "<space>f", ":Telescope find_files<cr>", opts)
keymap("n", "<space>u", ":Telescope oldfiles<cr>", opts)
keymap("n", "<space><space>", ":lua vim.lsp.buf.hover()<cr>", opts)

-- Search for a string in your current working directory and get results live as you type, respects .gitignore
keymap("n", "<C-f>", ":Telescope live_grep<cr>", opts)
keymap("n", "<C-l>", ":Telescope resume<cr>", opts)
keymap("n", "<space>b", ":Telescope buffers<cr>", opts)
-- keymap("n", "<leader>e", ":Telescope diagnostics<cr>", opts)
-- keymap("n", "<space>d", ":Telescope lsp_definitions<cr>", opts)
-- keymap("n", "<space>r", ":Telescope lsp_references<cr>", opts)
-- keymap("n", "<space>i", ":Telescope lsp_implementations<cr>", opts)
-- keymap("n", "<leader>g", ":Telescope git_status<cr>", opts)
-- keymap("n", "<space>ri", ":Telescope lsp_incoming_calls<cr>", opts)
-- keymap("n", "<space>ro", ":Telescope lsp_outgoing_calls<cr>", opts)

-- doc generation
keymap("n", "<leader>d", ":Neogen<cr>", opts)
keymap("n", "<leader>dc", ":Neogen class<cr>", opts)
keymap("n", "<leader>dt", ":Neogen type<cr>", opts)
keymap("n", "<leader>df", ":Neogen file<cr>", opts)

-- zen mode
keymap("n", "<leader>z", ":ZenMode<cr>", opts)

-- relative number
keymap("n", "<space>n", ":set invrelativenumber<cr>", opts)

-- lazygit
keymap("n", "<space>g", ":LazyGit<cr>", opts)

-- Toggle diagnostics
keymap("n", "<leader>n", "<Plug>(toggle-lsp-diag-vtext)", opts)

-- Yank keymaps
keymap({"n", "x"}, "p", "<Plug>(YankyPutAfter)", opts)
keymap({"n", "x"}, "P", "<Plug>(YankyPutBefore)", opts)

-- toggle-diagnostics
keymap("n", "<leader>e",
       ":lua vim.diagnostic.open_float(nil, {focus=false}) <cr>", opts)

-- Spectre replace in multiple files
keymap("n", "<C-r>", ":Spectre open<cr>", opts)

-- Mind open notes tree
keymap("n", "<space>n", ":MindOpenProject<cr>", opts)
-- :h mind-config-keymaps to view the keymaps
