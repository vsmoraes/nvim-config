return {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                kotlin = { "ktlint" },
                lua = { "stylua" },
                php = { "php_cs_fixer" },
                go = { "gofmt", "goimports" },
            },
            formatters = {
                php_cs_fixer = {
                    command = "php-cs-fixer",
                    args = {
                        "fix",
                        "--rules=@PSR12",
                        "$FILENAME",
                    },
                    stdin = false,
                },
            },
            format_on_save = {
                timeout_ms = 1000,
                lsp_fallback = true,
            },
        })

        -- Automatically install formatters
        require("mason-tool-installer").setup({
            ensure_installed = {
                "stylua",
                "ktlint",
                "php-cs-fixer",
                "goimports",
            },
            auto_update = false,
            run_on_start = true,
        })
    end,
}
