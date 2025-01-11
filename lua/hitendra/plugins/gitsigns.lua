return {
	"lewis6991/gitsigns.nvim",
	config = function()
		local gitsigns = require("gitsigns")
		gitsigns.setup({
			on_attach = function(bufnr)
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Text object for the hunk" })

				-- Navigation
				map("n", "<leader>cn", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Navigate to next hunk([C]hange [N]ext)" })
				map("n", "<leader>cp", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Navigate to previous hunk([C]hange [P]revious)" })

				-- Actions
				map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "[H]unk [S]tage" })
				map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "[H]unk [U]ndo stage" })
				map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "[H]unk [R]eset" })

				map("n", "<leader>gs", gitsigns.stage_buffer, { desc = "[G]it [S]tage the current buffer" })
				map("n", "<leader>gr", gitsigns.reset_buffer, { desc = "[G]it [R]eset the current buffer" })
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "[H]unk [P]review" })
				map("n", "<leader>hb", function()
					gitsigns.blame_line({ full = true })
				end, { desc = "Show [H]unk [B]lame" })
				map(
					"n",
					"<leader>bt",
					gitsigns.toggle_current_line_blame,
					{ desc = "[B]lame [T]oggle (toggle visibility of inline blames)" }
				)
				map("n", "<leader>bs", gitsigns.blame_line, { desc = "[B]lame [S]how (show blame for current line)" })
				map("n", "<leader>gd", gitsigns.diffthis, { desc = "Show [G]it [D]iff for current file" })
				map(
					"n",
					"<leader>td",
					gitsigns.toggle_deleted,
					{ desc = "[T]oggle [D]eleted (toggle deleted lines for currnt file)" }
				)

				-- map("n", "<leader>hD", function()
				-- 	gitsigns.diffthis("~")
				-- end)
			end,
		})
	end,
}
