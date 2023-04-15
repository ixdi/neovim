local status_ok, telescope = pcall(require, "telescope")
if not status_ok then return end

local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        shorten_path = true,
        path_display = {"smart"},
        file_ignore_patterns = {
            ".git", "node_modules", ".meteor", "public", "imports/externals",
            "packages"
        }
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
})

require("telescope").load_extension("yank_history")
require("telescope").load_extension("fzf")
