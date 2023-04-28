local signature_status_ok, signature = pcall(require, "lsp_signature")
if not signature_status_ok then return end

signature.setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {border = "rounded"}
})
