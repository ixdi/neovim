local status_ok, telescope = pcall(require, "telescope")
if not status_ok then return end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules", ".meteor/" }
  }
}

require("telescope").load_extension("yank_history")
