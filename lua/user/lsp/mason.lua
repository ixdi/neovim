local servers = {
	"lua_ls",
	"cssls",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"marksman",
}

-- INSTALLED in Mason by hand as we don't want some on lspconfig
-- 'bash-language-server',
-- 'beautysh',
-- 'black',
-- 'css-lsp',
-- 'djlint',
-- 'ember-language-server',
-- 'emmet-ls',
-- 'eslint-lsp',
-- 'flake8',
-- 'html-lsp',
-- 'json-lsp',
-- 'lua-language-server',
-- 'markdownlint',
-- 'marksman',
-- 'prettier',
-- 'pylint',
-- 'pyright',
-- 'stylua',
-- 'typescript-language-server',
-- 'yaml-language-server',
-- 'yamlfmt',

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
