return {
	-- Autopairs
	{
		"windwp/nvim-autopairs",
		keys = {
			{ "(", mode = "i" },
			{ "{", mode = "i" },
			{ "[", mode = "i" },
			{ '"', mode = "i" },
			{ "'", mode = "i" },
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
				"csharpier",
				"phpstan"
			},
			automatic_installation = true,
		},
		config = true,
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	-- formatting and lint
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")
			local formatting, diagnostics, code_actions =
					null_ls.builtins.formatting, null_ls.builtins.diagnostics, null_ls.builtins.code_actions

			local on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.keymap.set("n", "<Leader>ff", function()
						vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
					end, { buffer = bufnr, desc = "[lsp] format" })
				end
			end
			null_ls.setup({
				sources = {
					require("none-ls.diagnostics.eslint_d").with({
						condition = function(utils)
							return utils.root_has_file({ ".eslintrc.js", ".eslintrc.json" })
						end,
					}),
					diagnostics.phpstan,
					code_actions.gitsigns,
					require("none-ls.code_actions.eslint_d"),
					formatting.prettierd,
					formatting.prettier.with({
						filetypes = { "astro" }
					}),
					formatting.stylua,
					require("none-ls.formatting.rustfmt"),
					formatting.gofumpt,
					formatting.csharpier,
				},
				on_attach = on_attach,
			})
		end,
		dependencies = {
	     "nvimtools/none-ls-extras.nvim",
	   },
	},
	-- Indentation
	{
		"nmac427/guess-indent.nvim",
		event = "BufReadPre",
		cmd = "GuessIndent",
		opts = {
			auto_cmd = true,
			buftype_exclude = {
				"help",
				"nofile",
				"terminal",
				"prompt",
			},
		},
		config = true,
	},
	-- Text illumination
	{
		"RRethy/vim-illuminate",
		event = "BufReadPre",
		config = function()
			require("illuminate").configure()
		end,
	},
	-- Commeteer
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
							or vim.bo.commentstring
				end,
			},
		},
		config = true,
		dependencies = {
			{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
		},
	},
	-- Block Moves
	{
		"fedepujol/move.nvim",
		cmd = { "MoveLine", "MoveBlock" },
		config = true,
	},
}
