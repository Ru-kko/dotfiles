local keymap = vim.keymap.set
-- Save 
keymap("n", "<C-s>", ":w<CR>")
keymap("i", "<C-s>", "<ESC>:w<CR>")
keymap("v", "<C-s>", "<ESC>:w<CR>")

-- Quit 
keymap("n", "<C-q>", ":q")
keymap("n", "<C-q>", "<ESC>:q<CR>")
keymap("n", "<C-q>", "<ESC>:q<CR>")

-- Lazy
vim.keymap.set("n", "<leader>l", ":Lazy<CR>")

-- Lsp
keymap({"n", "i"},"<C-Enter>", "<cmd>Lspsaga goto_definition<CR>")
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

keymap("n", "s", "<cmd>Lspsaga hover_doc<CR>")
keymap({"n", "t"}, "<Leader>trm", "<cmd>Lspsaga term_toggle<CR>")
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

keymap("n", "<Leader>rr", ":LspRestart<CR>")
