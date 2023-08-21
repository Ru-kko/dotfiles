local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save
keymap({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", opts)

-- Close
keymap({ "n", "i", "v", "t" }, "<C-q>", function()
    local file_buf_count = vim.api.nvim_buf_call(0, function()
        local count = 0
        for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
            if buf.changed == 0 and vim.fn.bufname(buf.bufnr):match("^%a") then
                count = count + 1
            end
        end
        ---@diagnostic disable-next-line: redundant-return-value
        return count
    end)

    if file_buf_count < 1 then
        vim.cmd(":q")
    else
        vim.cmd(":bd")
    end
end, opts)

-- Line moviment
keymap({ "n", "i" }, "<A-j>", "<cmd>MoveLine(1)<CR>", opts)
keymap({ "n", "i" }, "<A-k>", "<cmd>MoveLine(-1)<CR>", opts)

keymap("v", "<A-j>", ":MoveBlock(1)<CR>", opts)
keymap("v", "<A-k>", ":MoveBlock(-1)<CR>", opts)

-- Lazy
keymap("n", "<leader>ll", ":Lazy<CR>")

-- Lsp
keymap({ "n", "i" }, "<C-Enter>", "<cmd>Lspsaga goto_definition<CR>", opts)
keymap("n", "<leader>dv", "<cmd>vsplit | Lspsaga goto_definition<CR>", opts)
keymap("n", "<leader>ds", "<cmd>split | Lspsaga goto_definition<CR>", opts)
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)

keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
keymap("n", "s", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "er", "<cmd>Lspsaga show_line_diagnostics", opts)
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", opts)
keymap("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", opts)
keymap("n", "<Leader>rr", ":LspRestart<CR>")
