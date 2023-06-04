local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
-- Save
keymap({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", opts)

-- Close
keymap({ "n", "i", "v" }, "<C-q>", function()
	local buffs = vim.api.nvim_list_bufs()
	local file_num = 0

	for _, buffer in ipairs(buffs) do
		local bufInfo = vim.fn.getbufinfo(buffer)
		if bufInfo[1].buflisted == 1 then
			file_num = file_num + 1
		end
	end

	if file_num <= 1 then
		vim.cmd("q")
	else
		vim.cmd("bd")
	end
end, opts)

-- Move lines like vscode
keymap({ "n", "i" }, "<A-j>", "<cmd>m .+1<CR>==")
keymap({ "n", "i" }, "<A-k>", "<cmd>m .-2<CR>==")

keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- Lazy
keymap("n", "<leader>ll", ":Lazy<CR>")

-- Lsp
keymap({ "n", "i" }, "<C-Enter>", "<cmd>Lspsaga goto_definition<CR>", opts)
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)

keymap("n", "s", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap({ "n", "t" }, "<Leader>trm", "<cmd>Lspsaga term_toggle<CR>", opts)
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
keymap("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)

keymap("n", "<Leader>rr", ":LspRestart<CR>")
