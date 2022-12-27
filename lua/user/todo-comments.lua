local todo_status_ok, todo = pcall(require, "todo-comments")
if not todo_status_ok then return end

todo.setup()
