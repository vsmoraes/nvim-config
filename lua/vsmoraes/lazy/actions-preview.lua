return {
    "aznhe21/actions-preview.nvim",
    config = function()
        require("actions-preview").setup {
            -- Configuration options
            diff = {
                ctxlen = 3,
            },
            backend = { "telescope" },
            telescope = vim.tbl_extend(
                "force",
                require("telescope.themes").get_dropdown(),
                {
                    make_value = nil,
                    make_make_display = nil,
                }
            ),
        }
    end,
}
