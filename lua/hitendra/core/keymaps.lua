-- pressing escapte key removes highlights from search terms
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- easy insert to normal mode
vim.keymap.set("i", "jj", "<Esc>")
-- vim.keymap.set("n", "<leader>pv", ":Ex<CR>")

-- easy access to black hole register
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d')

-- easy navigation in line
vim.keymap.set({ "n", "v", "o" }, "L", "$", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "o" }, "H", "^", { noremap = true, silent = true })

-- making surrounding more easy
vim.keymap.set("o", "ir", "i[")
vim.keymap.set("o", "ar", "a[")

-- making redo as `U`: Originally U is used to undo last changed line
vim.keymap.set("n", "U", "<C-r>")

-- cut line in insert mode
vim.keymap.set("i", "<C-x>", function()
	vim.api.nvim_command("normal! dd")
end, { noremap = true })

-- select all made easy
-- (<C-a> is for increasing a number and <C-x> is for decreasing a number)
-- vim.keymap.set("n", "<C-a>", "ggVG")

-- indent in viaual mode without losing selection
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [D]iagnostic [Q]uickfix list" })

-- split windows
vim.keymap.set("n", "<leader>sv", "<cmd>vs<CR>")
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>")
vim.api.nvim_set_keymap("n", "<C-w>H", ":wincmd H<CR>:vertical resize 40<CR>", { noremap = true, silent = true })

-- Tab navigation
vim.keymap.set("n", "<A-h>", ":tabprevious<CR>")
vim.keymap.set("n", "<A-l>", ":tabnext<CR>")
vim.keymap.set("n", "<A-Left>", ":-tabmove<CR>")
vim.keymap.set("n", "<A-Right>", ":+tabmove<CR>")
vim.keymap.set("n", "<A-w>", ":tabclose<CR>")

-------------------- Move Lines -----------------------
-- Move selected multiple lines
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- Move current line
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })

------------------- Move Up and Down with cursor in center ---------------
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

------------------- Navigate in wrapped lines ---------------
vim.keymap.set({ "n", "v", "i" }, "<Down>", function()
	return vim.fn.mode() == "i" and "<C-o>gj" or "gj"
end, { expr = true })
vim.keymap.set({ "n", "v", "i" }, "<Up>", function()
	return vim.fn.mode() == "i" and "<C-o>gk" or "gk"
end, { expr = true })
