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
				"gopls",
				"pyright",
				"html",
				"ts_ls",
				"cssls",
				"tailwindcss",
				"emmet_ls",
				"lua_ls",
				"rust_analyzer",
				"angularls@17.2.2",
			},
			automatic_installation = true,
		})
	end,
}
