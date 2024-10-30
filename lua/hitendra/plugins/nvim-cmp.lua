return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		"hrsh7th/cmp-nvim-lsp-signature-help", -- to display function signature
		-- "ray-x/lsp_signature.nvim",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim", -- vs-code like pictograms
	},
	config = function()
		local cmp = require("cmp")

		local lspkind = require("lspkind")
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				-- Scroll the documentation window [b]ack / [f]orward
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),

				-- Accept the completion suggestion
				-- ["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
				-- navigate through available list of suggestions

				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

				-- Manually trigger a completion from nvim-cmp.
				-- ["<C-s>"] = cmp.mapping.complete()
				["<C-s>"] = function()
					if cmp.visible() then
						cmp.close()
					else
						cmp.complete()
					end
				end,
			}),

			sources = {
				{ name = "nvim_lsp_signature_help" },
				{ name = "nvim_lsp" }, -- snippets
				{ name = "luasnip" }, -- snippets
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			},

			-- configure lspkind for vs-code like pictograms in completion menu
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol", -- show only symbol annotations
					-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					maxwidth = 50,
					-- can also be a function to dynamically calculate max width such as
					-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default
				}),
			},
		})
	end,
}
