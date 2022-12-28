vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"qf", "help", "man", "lspinfo", "spectre_panel"},
    callback = function()
        vim.cmd([[
      nnoremap <silent> <buffer> q :close<cr>
      set nobuflisted
    ]])
    end
})

vim.api.nvim_create_autocmd({"VimEnter"}, {
    callback = function() vim.cmd("hi link illuminatedWord LspReferenceText") end
})

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
    callback = function()
        local line_count = vim.api.nvim_buf_line_count(0)
        if line_count >= 5000 then vim.cmd("IlluminatePauseBuf") end
    end
})

-- Automatically clean trailing whitespace
vim.cmd("autocmd BufWritePre * :%s/s+$//e")
-- Remove trialing lines
-- vim.cmd("autocmd BufWritePre * :%s#\($\n\s*\)\+\%$##e")
-- Mark extra whitespace as red
vim.cmd("autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red")
-- vim.cmd("autocmd InsertLeave * match ExtraWhitespace /\s\+\%#\@<!$/")

-- on autoload change filetypes for html to handlebars
vim.cmd(
    "autocmd BufReadPost,BufNewFile *.html set filetype=html.handlebars syntax=handlebars")
-- vim.cmd("autocmd BufRead,BufNewFile *rc set filetype=json")
