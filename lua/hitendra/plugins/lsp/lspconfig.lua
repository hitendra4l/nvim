return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "j-hui/fidget.nvim", opts = {} }, -- shows lsp loading and progress on bottom right corner
	},
	config = function()
		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")
		local mason_registry = require("mason-registry")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Add border to LspInfo window
		require("lspconfig.ui.windows").default_options.border = "rounded"

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
			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "<leader>dn", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "<leader>dp", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, opts)

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

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
			-- cmd = { "typescript-language-server", "--stdio" },
			-- version = "/home/hitendra/.local/share/nvim/mason/bin/typescript-language-server --version",
			init_options = {
				preferences = {
					disableSuggestions = true,
				},
			},
			settings = {
				javascript = {
					suggest = {
						enabled = true,
					},
				},
			},
		})

		lspconfig["cssls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				css = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
				less = {
					validate = true,
				},
				scss = {
					validate = true,
				},
			},
		})

		------- Custom root_dir function
		-- local tailwindcss_root_files = {
		-- 	"tailwind.config.js",
		-- 	"tailwind.config.cjs",
		-- 	"tailwind.config.mjs",
		-- 	"tailwind.config.ts",
		-- }
		-- lspconfig["tailwindcss"].setup({
		-- 	capabilities = capabilities,
		-- 	on_attach = on_attach,
		-- 	filetypes = {
		-- 		"html",
		-- 		"htmlangular",
		-- 		"css",
		-- 		"less",
		-- 		"postcss",
		-- 		"sass",
		-- 		"scss",
		-- 		"javascriptreact",
		-- 		"typescriptreact",
		-- 	},
		-- 	root_dir = function(fname)
		-- 		-- Use root_pattern to detect Tailwind config files and fallback to the git ancestor
		-- 		return util.root_pattern(unpack(tailwindcss_root_files))(fname) or util.find_git_ancestor(fname)
		-- 	end,
		-- })

		lspconfig["emmet_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "htmlangular" },
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
			table.concat({ angularls_path, vim.fn.getcwd() }, ","),
			"--ngProbeLocations",
			table.concat({ angularls_path .. "/node_modules/@angular/language-server", vim.fn.getcwd() }, ","),
		}
		-- Custom root_dir function
		local angularls_root_files = {
			"angular.json", -- standard Angular config
			"workspace.json", -- Nx monorepos can use this instead of angular.json
			"nx.json", -- Nx root config
			"project.json", -- individual project config
		}
		lspconfig["angularls"].setup({
			cmd = cmd,
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = function(fname)
				return util.root_pattern(unpack(angularls_root_files))(fname) or util.find_git_ancestor(fname)
			end,
			on_new_config = function(new_config, _)
				new_config.cmd = cmd
			end,
		})

		local log_file = io.open("/home/hitendra/logfile.txt", "a")
		if log_file then
			log_file:write("ANGULAR" .. table.concat(cmd, " "))
			log_file:close()
		else
			print("Failed to open log file for writing")
		end

		-- Docker lsp's
		lspconfig["dockerls"].setup({})
		lspconfig["docker_compose_language_service"].setup({})
	end,
}
