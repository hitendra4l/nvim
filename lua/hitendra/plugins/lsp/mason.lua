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
		-- mason_lspconfig.setup_handlers({
		-- 	-- Will be called for each installed server that doesn't have
		-- 	-- a dedicated handler.
		-- 	--
		-- 	function(server_name) -- default handler (optional)
		-- 		-- https://github.com/neovim/nvim-lspconfig/pull/3232
		-- 		if server_name == "tsserver" then
		-- 			server_name = "ts_ls"
		-- 		end
		-- 		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		-- 		require("lspconfig")[server_name].setup({
		--
		-- 			capabilities = capabilities,
		-- 		})
		-- 	end,
		-- })
	end,
}
