local status_ok, cmp = pcall(require, "cmp")
if not status_ok then return end

local luas_status_ok, luasnip = pcall(require, "luasnip")
if not luas_status_ok then return end

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip/loaders/from_snipmate").lazy_load()

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<esc>"] = cmp.mapping.abort(),
        -- salta al proximo snippet
        ["<C-d>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<CR>"] = cmp.mapping.confirm({select = true}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Down>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item() end
        end, {"i", "s"}),
        ["<Up>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item() end
        end, {"i", "s"}),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {"i", "s"}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"})
    }),
    formatting = {
        fields = {"kind", "abbr", "menu"},
        format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind]
            vim_item.menu = ({
                nvim_lsp = "",
                nvim_lua = "",
                luasnip = "",
                buffer = "",
                path = "",
                emoji = ""
            })[entry.source.name]
            return vim_item
        end
    },
    sources = {
        {name = "nvim_lsp"}, {name = "nvim_lua"}, {name = "luasnip"},
        {name = "buffer"}, {name = "path"}, {name = "treesitter"}
    },
    confirm_opts = {behavior = cmp.ConfirmBehavior.Replace, select = false},
    experimental = {ghost_text = true}
})

-- -- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'cmp_git' } -- You can specify the `cmp_git` source if you were installed it.
--   }, { { name = 'buffer' } })
-- })
--
-- -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline({ '/', '?' }, {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = { { name = 'buffer' } }
-- })
--
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
-- })
