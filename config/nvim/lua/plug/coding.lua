return {
	-- Autopairs
	{
    "windwp/nvim-autopairs",
    keys = {
      { "(", mode = "i" },
      { "{", mode = "i" },
      { "[", mode = "i" },
      { '"', mode = "i" },
      { "'", mode = "i" }
    },
    config = true,
  },
	-- Null-ls installer
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"prettierd",
				"prettier",
				"rustfmt",
				"gofumpt",
				"eslint_d",
				"stylua",
			},
			automatic_installation = true,
		},
		config = true,
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
	},
	-- formatting and lint
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")
			local formatting, diagnostics = null_ls.builtins.formatting, null_ls.builtins.diagnostics

			local on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.keymap.set("n", "<Leader>ff", function()
						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
					end, { buffer = bufnr, desc = "[lsp] format" })
				end
			end
			null_ls.setup({
				sources = {
					diagnostics.eslint_d.with({
						condition = function(utils)
							return utils.root_has_file({ ".eslintrc.js" })
						end,
					}),
					formatting.prettierd,
					formatting.stylua,
					formatting.rustfmt,
					formatting.gofumpt,
				},
				on_attach = on_attach,
			})
		end,
	},
}