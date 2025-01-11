return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		vim.keymap.set("n", "<leader>sp", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Open harpoon-telescope window [S]earch [P]rimeagen" })

		vim.keymap.set("n", "<leader>p", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon window [P]rimeagen" })

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add current file to harpoon list. [A]dd" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
	opts = function(_, opts)
		opts.settings = {
			save_on_toggle = false,
			sync_on_ui_close = false,
			save_on_change = false,
			excluded_filetypes = { "harpoon", "alpha", "dashboard", "gitcommit" },
			mark_branch = true,
		}
	end,
}
