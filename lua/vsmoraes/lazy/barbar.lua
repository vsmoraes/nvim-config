return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        animation = true,
        auto_hide = false,
        tabpages = true,
        clickable = true,
        icons = {
            button = '',
            separator = {left = '▎', right = ''},
            inactive = {separator = {left = '▎', right = ''}},
        },
    },
}
