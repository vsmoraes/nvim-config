return {
    "mbbill/undotree",
    config = function()
        -- Configure undotree to focus on the undo tree window when opened
        vim.g.undotree_SetFocusWhenToggle = 1

        -- Show diff in a horizontal split below
        vim.g.undotree_WindowLayout = 2

        -- Shorter timestamps
        vim.g.undotree_ShortIndicators = 1
    end,
}
