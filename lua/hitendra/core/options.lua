-- defining leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show which line your cursor is on (Highlight current line)
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- tab space
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- line wrapping
vim.opt.breakindent = true
vim.o.wrap = true
vim.o.linebreak = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- make system clipboard and yank register same
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Save undo history
vim.opt.undofile = true

-- it ignores the cases when searching lowercase but enables it when we write in UPPERCASE
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn(shows lil icons on gutter) on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.o.equalalways = false

-- vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})



------------------------------ border on suggestions ------------------------------------
local lsp = vim.lsp
lsp.handlers["textDocument/hover"] = lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})


------------------------------ border on diagnostics ------------------------------------
local api = vim.api
local diagnostic = vim.diagnostic
api.nvim_create_autocmd("CursorHold", {
	callback = function()
		local float_opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = "rounded",
			source = "always", -- show source in diagnostic popup window
			prefix = " ",
		}

		if not vim.b.diagnostics_pos then
			vim.b.diagnostics_pos = { nil, nil }
		end

		local cursor_pos = api.nvim_win_get_cursor(0)
		if (cursor_pos[1] ~= vim.b.diagnostics_pos[1] or cursor_pos[2] ~= vim.b.diagnostics_pos[2])
				and #diagnostic.get() > 0
		then
			diagnostic.open_float(nil, float_opts)
		end

		vim.b.diagnostics_pos = cursor_pos
	end,
})

vim.diagnostic.config {
	float = { border = "rounded" },
}

-- ---------------------- cursor in center near EOF ------------------------------
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
	group = vim.api.nvim_create_augroup("ScrollOffEOF", {}),
	callback = function()
		local win_h = vim.api.nvim_win_get_height(0)
		local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
		local dist = vim.fn.line "$" - vim.fn.line "."
		local rem = vim.fn.line "w$" - vim.fn.line "w0" + 1
		if dist < off and win_h - rem + dist < off then
			local view = vim.fn.winsaveview()
			view.topline = view.topline + off - (win_h - rem + dist)
			vim.fn.winrestview(view)
		end
	end,
})
