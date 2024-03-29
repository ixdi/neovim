local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then return end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local code_actions = null_ls.builtins.code_actions

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
    debug = false,
    sources = {
        code_actions.eslint_d, code_actions.gitsigns, code_actions.refactoring,
        -- code_actions.eslint,
        -- diagnostics.ansiblelint,
        -- diagnostics.codespell,
        -- diagnostics.djlint,
        diagnostics.eslint_d.with({disabled_filetypes = {"typescript"}}), -- diagnostics.eslint,
        diagnostics.luacheck, -- diagnostics.flake8,
        -- diagnostics.jsonlint,
        diagnostics.markdownlint, -- diagnostics.misspell,
        diagnostics.pylint, -- diagnostics.stylelint,
        -- diagnostics.tidy,
        diagnostics.vint, -- diagnostics.zsh,
        -- formatting.autopep8,
        formatting.isort, formatting.black, formatting.stylua,
        formatting.beautysh, -- formatting.djlint,
        -- formatting.eslint_d, -- formatting.eslint,
        formatting.fixjson, formatting.lua_format, formatting.markdownlint,
        formatting.prettierd, formatting.yamlfmt
        -- hover.printenv
    },
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    if vim.bo.filetype == "html.handlebars" then
                        vim.cmd.normal({"gg=G", bang = true})
                    else
                        vim.lsp.buf.format({
                            bufnr = bufnr,
                            filter = function(_client)
                                return _client.name == "null-ls"
                            end
                        })
                    end
                end
            })
        end
    end
})
