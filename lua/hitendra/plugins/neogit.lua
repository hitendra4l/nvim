return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		"nvim-telescope/telescope.nvim", -- optional
	},
	config = function()
		local neogit = require("neogit")
		neogit.setup({
			signs = {
				-- { CLOSED, OPENED }
				hunk = { "", "" },
				item = { "", "" },
				section = { "", "" },
			},
		})
	end,
}
