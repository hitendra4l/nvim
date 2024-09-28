return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		--
		-- setup options
		require("nvim-tree").setup({
			-- hijack_cursor = true,
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
				preserve_window_proportions = true,
				-- float = {
				-- 	enable = true,
				-- 	quit_on_focus_loss = false
				-- }
			},
			-- actions = {
			-- 	open_file = {
			-- 		resize_window = false
			-- 	}
			-- },
			renderer = {
				full_name = true,
				group_empty = false,
				highlight_git = "all",
				-- highlight_diagnostics = "icon",
				hidden_display = "all"
			},
			filters = {
				dotfiles = false,
				git_ignored = false,
			},
			git = {
				enable = true,
				show_on_dirs = true,
				timeout = 3000,
			},
			update_focused_file = {
				enable = true,
			},
		})

		------ Keymaps -------
		vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")  -- toggle file explorer
		vim.keymap.set("n", "<leader>el", "<cmd>NvimTreeResize +5<CR>") -- increases the size
		vim.keymap.set("n", "<leader>eh", "<cmd>NvimTreeResize -5<CR>") -- decreases the size

		-- toggle the focus between file and tree
		vim.keymap.set("n", "<leader>ef", function()
			local view = require("nvim-tree.view")
			if view.is_visible() and vim.api.nvim_get_current_win() == view.get_winnr() then
				-- If nvim-tree is focused, switch to the previous window
				vim.cmd("wincmd p")
			else
				-- If nvim-tree is not focused, focus on it
				vim.cmd("NvimTreeFocus")
			end
		end)
	end,
}
