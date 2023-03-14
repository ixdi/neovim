local refactoring_status_ok, refactoring = pcall(require, "refactoring")
if not refactoring_status_ok then return end

refactoring.setup({
    prompt_func_return_type = {
        c = false,
        cpp = true,
        cxx = false,
        go = false,
        h = false,
        hpp = false,
        java = false,
        js = true,
        ts = true,
        py = true
    },
    prompt_func_param_type = {
        c = false,
        cpp = true,
        cxx = false,
        go = false,
        h = false,
        hpp = false,
        java = false,
        js = true,
        ts = true,
        py = true
    },
    printf_statements = {},
    print_var_statements = {}
})

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")

-- prompt for a refactor to apply when the remap is triggered
vim.api.nvim_set_keymap("v", "<leader>rr",
                        "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
                        {noremap = true})
