vim.o.updatetime = 250
-- vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.keymap.set("n", "<leader>ee",
               ":lua vim.diagnostic.open_float(nil, {focus=false})<cr>")

require("toggle_lsp_diagnostics").init({virtual_text = false})
