local status_ok, comment = pcall(require, "neogen")
if not status_ok then return end

local todo_status_ok, todo = pcall(require, "todo-comments")
if not todo_status_ok then return end

comment.setup({
  languages = {
    lua = { template = { annotation_convention = "emmylua" } },
    python = { template = { annotation_convention = "reST" } },
    typescript = { template = { annotation_convention = "jsdoc" } }
  }
})

todo.setup()
