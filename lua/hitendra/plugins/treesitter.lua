return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",              -- Sets main module to use for opts
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects", -- Add textobjects as a dependency
	},
	config = function()
		-- Set the compilers to be used by nvim-treesitter
		require("nvim-treesitter.install").compilers = { "zig", "clang", "gcc" }
		require("nvim-treesitter.configs").setup({
			matchup = {
				enable = false, -- for matching-tag plugin true didn't work idk why?
				disable = { "c", "ruby" },
			},
			ensure_installed = {
				"html",
				"lua",
				"markdown",
				"markdown_inline",
			},
			sync_install = false,       -- Sync installation of parsers
			auto_install = true,        -- Autoinstall languages that are not installed
			ignore_install = { "" },    -- List of parsers to ignore installing
			autopairs = { enable = true }, -- Enable autopairs
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					-- We don't have to be precise when using this
					-- this will automatically detect the text object
					lookahead = true,
					keymaps = {
						-- Keymaps to select inside and around the function
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
				swap = {
					enable = true,
					-- Keymaps to swap parameters inside function
					swap_next = {
						["<leader>a"] = "@parameter.inner",
					},
					swap_previous = {
						["<leader>A"] = "@parameter.inner",
					},
				},
			},
		})
	end,
}
