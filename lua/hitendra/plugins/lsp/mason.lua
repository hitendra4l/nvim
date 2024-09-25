return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		mason.setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜ ",
					package_uninstalled = "✗",
				},
			},
		})
		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"angularls",
				"rust_analyzer",
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"emmet_ls",
				"pyright",
				"ts_ls",
			},
			automatic_installation = true,
		})
	end,
}
