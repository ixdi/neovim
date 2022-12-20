local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then return end

local nvim_tree_config = require("nvim-tree.config")

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
  update_focused_file = { enable = true, update_cwd = true },
  renderer = {
    group_empty = true,
    root_folder_modifier = ":t",
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_open = "",
          arrow_closed = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = ""
        },
        git = {
          unstaged = "",
          staged = "S",
          unmerged = "",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌"
        }
      }
    }
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = { hint = "", info = "", warning = "", error = "" }
  },
  view = {
    adaptive_size = true,
    -- width = 30
    side = "left",
    mappings = {
      list = {
        { key = "s", action = "split" }, { key = "v", action = "vsplit" },
        { key = "sy", action = "system_open" },
        { key = "o", action = "edit_no_picker" }
      }
    }
  },
  filters = { dotfiles = true }
}
