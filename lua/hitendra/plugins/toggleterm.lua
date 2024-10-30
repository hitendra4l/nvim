return {
	"akinsho/nvim-toggleterm.lua",
	config = function()
		local toggleterm = require("toggleterm")

		toggleterm.setup({
			open_mapping = [[<c-\>]],
			hide_number = true,
			start_in_insert = true,
			direction = "float", -- vertical | float | tab | horizontal
			persist_mode = false,
			float_opts = {
				border = "curved", -- single | double | shadow | curved
				title_pos = "center", -- 'left' | 'center' | 'right'
			},
		})
		-- Function to set terminal keymaps
		function _G.set_terminal_keymaps()
			local opts = { noremap = true, silent = true }
			-- Remap Esc to enter normal mode without closing the terminal
			vim.api.nvim_buf_set_keymap(0, "t", "<Esc>", [[<C-\><C-n>]], opts)
		end

		-- Apply the keymap when a terminal is opened
		vim.cmd([[
      autocmd! TermOpen term://* lua set_terminal_keymaps()
    ]])
	end,
}
