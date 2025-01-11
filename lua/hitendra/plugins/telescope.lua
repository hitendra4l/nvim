return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			version = "^1.0.0",
		},
	},
	config = function()
		local telescope = require("telescope")
		-- "foo" --iglob **/test/**
		local lga_actions = require("telescope-live-grep-args.actions")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-j>"] = "move_selection_next",
						["<C-k>"] = "move_selection_previous",
					},
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				live_grep_args = {
					auto_quoting = true,
					mappings = { -- extend mappings
						i = {
							-- ["<C-k>"] = lga_actions.quote_prompt(), -- just remove --iglob
							-- add [P]ath
							["<C-p>"] = lga_actions.quote_prompt({ postfix = " --iglob **" }),
							-- [R]efine search
							["<C-r>"] = actions.to_fuzzy_refine,
						},
					},
				},
			},
		})

		-- then load the extension
		telescope.load_extension("live_grep_args")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>so",
			"<cmd>Telescope lsp_references<CR>",
			{ desc = "[S]earch [O]ccurence", noremap = true, silent = true }
		)
		-- vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
	end,
}
