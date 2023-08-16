local status_ok_treesitter, treesitter = pcall(require, "nvim-treesitter")
if not status_ok_treesitter then return end

local status_ok_configs, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok_configs then return end

configs.setup({
    -- A list of parser names, or "all"
    ensure_installed = {
        "javascript", "html", "css", "scss", "json", "typescript", "yaml",
        "python", "toml", "glimmer", "jsdoc", "tsx", "lua", "markdown", "bash",
        "dockerfile", "comment"
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = {""},

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {""},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    },
    autotag = {
        enable = true
        -- filetypes = {"html", "html.handlebars", "handlebars", "mustache", "xml"}
    },
    incremental_selection = {enable = true},
    indent = {enable = true}
    -- rainbow = {
    --     enable = true,
    --     -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    --     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    --     max_file_lines = nil -- Do not enable for files with more than n lines, int
    --     -- colors = {}, -- table of hex strings
    --     -- termcolors = {} -- table of colour name strings
    -- }
})

-- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
-- parser_config.glimmer = {
--     filetype = "handlebars",
--     used_by = {"mustache", "handlebars", "html.handlebars", "spacebars", "html"}
-- }
