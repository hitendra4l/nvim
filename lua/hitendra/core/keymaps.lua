-- pressing escapte key removes highlights from search terms
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- easy insert to normal mode
vim.keymap.set("i", "jj", "<Esc>")
-- vim.keymap.set("n", "<leader>pv", ":Ex<CR>")

-- cut line in insert mode
vim.keymap.set("i", "<C-x>", function()
	vim.api.nvim_command("normal! dd")
end, { noremap = true })

-- select all made easy
vim.keymap.set("n", "<C-a>", "ggVG")

-- indent in viaual mode without losing selection
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [D]iagnostic [Q]uickfix list" })

-- split window navigation
vim.keymap.set("n", "<C-Left>", "<C-w>h")
vim.keymap.set("n", "<C-Down>", "<C-w>j")
vim.keymap.set("n", "<C-Up>", "<C-w>k")
vim.keymap.set("n", "<C-Right>", "<C-w>l")

-- split windows
vim.keymap.set("n", "<leader>sv", "<cmd>vs<CR>")
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>")
vim.api.nvim_set_keymap('n', '<C-w>H', ':wincmd H<CR>:vertical resize 40<CR>', { noremap = true, silent = true })

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
-- Combined normal and visual mode mappings
vim.keymap.set({ 'n', 'v' }, '<Down>', 'gj')
vim.keymap.set({ 'n', 'v' }, '<Up>', 'gk')

-- Insert mode mappings
vim.keymap.set('i', '<Down>', '<C-o>gj')
vim.keymap.set('i', '<Up>', '<C-o>gk')
