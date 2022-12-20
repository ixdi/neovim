local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then return end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" }
    }, formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    diagnostics.flake8,
    -- builtins.code_actions.eslint,
    diagnostics.ansiblelint,
    -- diagnostics.codespell,
    diagnostics.djlint,
    -- diagnostics.eslint,
    -- diagnostics.luacheck,
    diagnostics.jsonlint,
    diagnostics.markdownlint,
    -- diagnostics.misspell,
    diagnostics.pylint,
    -- diagnostics.stylelint,
    -- diagnostics.tidy,
    diagnostics.vint,
    -- diagnostics.zsh,
    formatting.autopep8,
    formatting.beautysh,
    -- formatting.eslint,
    formatting.djlint, null_ls.builtins.formatting.fixjson,
    formatting.lua_format,
    formatting.markdownlint,
    formatting.prettierd,
    formatting.yamlfmt
    -- hover.printenv 
  },
}
