-- return {
-- 	"scottmckendry/cyberdream.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	init = function()
-- 		vim.cmd.colorscheme("cyberdream")
-- 	end,
-- 	opts = {
-- 		transparent = true,
-- 		-- italic_comments = true,
-- 		-- hide_fillchars = true,
-- 		-- terminal_colors = true,
-- 		borderless_telescope = false,
-- 		extensions = {
-- 			telescope = false,
-- 		},
-- 		theme = {
-- 			variant = "auto",
-- 			overrides = function(t)
-- 				return { SmartOpenDirectory = { fg = t.grey } }
-- 			end,
-- 		},
-- 	}
-- }


return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
	opts = {
		transparent_background = true,
		-- no_italic = true,
	}
}

-- return {
-- 	"rebelot/kanagawa.nvim",
-- 	priority = 1000,
-- 	overrides = function(colors)
-- 		local theme = colors.theme
-- 		return {
-- 			NormalFloat = { bg = "none" }, -- Transparent background for focused windows
-- 			FloatBorder = { bg = "none" },
-- 			FloatTitle = { bg = "none" },
--
-- 			NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
--
-- 			LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
-- 			MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
-- 		}
-- 	end,
-- 	opts = {
-- 		colors = {
-- 			theme = {
-- 				all = {
-- 					ui = {
-- 						bg_gutter = "none",
-- 					},
-- 				},
-- 			},
-- 		},
-- 		transparent = true,
-- 		theme = "dragon",
-- 	},
-- 	init = function()
-- 		vim.cmd.colorscheme("kanagawa")
-- 		vim.cmd.hi("Comment gui=none")
-- 		vim.opt.winblend = 10
--
-- 		-- Function to set background transparency based on focus
-- 		local function update_window_highlights()
-- 			local current_win = vim.api.nvim_get_current_win()
-- 			local wins = vim.api.nvim_list_wins()
--
-- 			for _, win in ipairs(wins) do
-- 				if win == current_win then
-- 					-- Focused window: Transparent background
-- 					vim.api.nvim_win_set_option(win, "winhighlight", "Normal:NormalDark")
-- 				else
-- 					-- Unfocused windows: Non-transparent background
-- 					vim.api.nvim_win_set_option(win, "winhighlight", "Normal:NormalFloat")
-- 				end
-- 			end
-- 		end
--
-- 		-- Trigger the function on window focus change
-- 		vim.api.nvim_create_autocmd({ "WinEnter", "WinLeave", "BufEnter" }, {
-- 			callback = update_window_highlights,
-- 		})
--
-- 		-- Initial setup
-- 		-- update_window_highlights()
-- 	end,
-- }

-- return {
-- 	"folke/tokyonight.nvim",
-- 	opts = {
-- 		priority = 1000, -- Make sure to load this before all the other start plugins.
-- 		transparent = true,
-- 		styles = {
-- 			sidebars = "transparent",
-- 			-- floats = "transparent",
-- 			comments = { italic = false },
-- 			keywords = { italic = false },
-- 			functions = { italic = false },
-- 			variables = { italic = false },
-- 		},
-- 	},
-- 	init = function()
-- 		vim.cmd.colorscheme("tokyonight-night")
-- 		vim.cmd.hi("Comment gui=none")
-- 		vim.opt.winblend = 10
-- 	end,
-- }
