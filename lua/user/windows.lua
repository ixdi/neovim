local windows_status_ok, windows = pcall(require, "windows")
if not windows_status_ok then return end

windows.setup()
