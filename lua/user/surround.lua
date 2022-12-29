local sur_status_ok, surround = pcall(require, "nvim-surround")
if not sur_status_ok then return end

surround.setup({
    keymaps = {
        -- insert = "<C-g>s",
        -- insert_line = "<C-g>S",
        -- normal = "ys",
        -- normal_cur = "yss",
        -- normal_line = "yS",
        -- normal_cur_line = "ySS",
        -- visual = "S",
        -- visual_line = "gS",
        delete = "<leader>ds",
        change = "<leader>cs"
    }
})
