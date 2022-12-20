vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

require('toggle_lsp_diagnostics').init({ virtual_text = false })
