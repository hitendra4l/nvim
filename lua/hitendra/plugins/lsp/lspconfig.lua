return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		-- { "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")

		local mason_registry = require("mason-registry")

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }

		local on_attach = function(_, bufnr)
			opts.buffer = bufnr

			---------------------- Helps ----------------------
			-- smart rename
			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			-- show documentation for what is under cursor
			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts)

			------------------- Find family ----------------
			-- show definition, references
			opts.desc = "Show LSP references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

			-- go to declaration
			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			-- show lsp definitions
			opts.desc = "Go to the LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			-- show lsp implementations
			opts.desc = "Go to the LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			-- it goes to the type of whatever is under the cursor
			opts.desc = "Go to the LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			----------------------- Diagnostics ------------------------
			-- show diagnostics for line
			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)

			-- jump to next diagnostic in buffer
			opts.desc = "Go to next diagnostic"
			keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, opts)

			-- jump to previous diagnostic in buffer
			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, opts)

			-- list all of the diagnostics in the buffer using Telescope
			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			-- see available code actions, in visual mode will apply to selection
			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			------------------ If something breaks ----------------------------
			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = "󰅙 ", Warn = " ", Hint = " ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig["pyright"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["html"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["ts_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				javascript = {
					suggest = {
						enabled = true
					}
				}
			}
		})

		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				css = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					}
				},
			},
		})

		lspconfig["tailwindcss"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css" },
		})

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			on_init = function(client)
				-- Extend the current Lua settings with runtime and workspace configurations
				client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
					runtime = {
						-- Specify LuaJIT as the runtime version (used by Neovim)
						version = "LuaJIT",
					},
					workspace = {
						checkThirdParty = false, -- Skip checking third-party files
						library = {
							vim.env.VIMRUNTIME, -- Add Neovim runtime files
							-- Additional paths can be added here if necessary
						},
					},
				})
			end,
			settings = {
				Lua = {
					-- Make the language server recognize "vim" as a global variable
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							-- Include Neovim runtime and your custom config paths
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
					completion = {
						callSnippet = "Replace", -- Set how call snippets are displayed
					},
				},
			},
		})

		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Angular Language Server configuration
		local angularls_path = mason_registry.get_package("angular-language-server"):get_install_path()

		local cmd = {
			"ngserver",
			"--stdio",
			"--tsProbeLocations",
			table.concat({ angularls_path, vim.loop.cwd() }, ","),
			"--ngProbeLocations",
			table.concat({ angularls_path .. "/node_modules/@angular/language-server", vim.loop.cwd() }, ","),
		}

		lspconfig["angularls"].setup({
			cmd = cmd,
			capabilities = capabilities,
			on_attach = on_attach,
			on_new_config = function(new_config, _)
				new_config.cmd = cmd
			end,
		})
	end,
}
