return {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                kotlin = { "ktlint" },
                lua = { "stylua" },
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_fallback = "fallback"
            },
        })

        -- Optional: Manual format keybinding
        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
