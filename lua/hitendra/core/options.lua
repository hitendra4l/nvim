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
