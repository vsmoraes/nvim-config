return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local lint = require("lint")

		-- Configure linters by filetype
		lint.linters_by_ft = {
			kotlin = { "ktlint" },
			php = { "phpcs" },
			go = { "golangcilint" },
			lua = { "luacheck" },
		}

		-- Automatically install linters
		require("mason-tool-installer").setup({
			ensure_installed = {
				"ktlint",
				"phpcs",
				"golangci-lint",
				"luacheck",
			},
			auto_update = false,
			run_on_start = true,
		})

		-- Create autocommand to run linters
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
