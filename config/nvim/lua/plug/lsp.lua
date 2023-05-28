local servers = {
	"lua_ls",
	"jdtls",
	"tsserver",
	"emmet_ls",
}

local null_deps = {}

local function attach_keys(_, buf)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(buf, ...)
	end
	local opts = { noremap = true, silent = true }

	buf_set_keymap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("i", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			servers = {
				jdtls = require("langs.java"),
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
				tsserver = {
					on_attach = function(client)
						client.resolved_capabilities.document_formatting = false
					end,
				},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local null_ls = require("null-ls")

			lspconfig.util.default_config.capabilities =
					vim.tbl_deep_extend("force", lspconfig.util.default_config.capabilities, capabilities)

			for _, server in pairs(servers) do
				local sv = lspconfig[server]

				if sv.on_attach then
					sv.on_attach = function(...)
						sv.on_attach(...)
						attach_keys(...)
					end
				else
					sv.on_attach = attach_keys
				end

				if sv.capabilities == nil then
					sv.capabilities = capabilities
				end
				sv.setup(opts.servers[server] or {})
			end
		end,
		dependencies = {
			"hrsh7th/nvim-cmp",
			"jose-elias-alvarez/null-ls.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "folke/neodev.nvim", opts = {} },
		},
	},
	{
		"williamboman/mason.nvim",
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = servers,
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
		end,
	},
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
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				formatting = {
					fields = { "menu", "abbr", "kind" },
					format = function(entry, item)
						local menu_icon = {
							nvim_lsp = "λ",
							vsnip = "⋗",
							buffer = "Ω",
							path = "🖫",
						}
						item.menu = menu_icon[entry.source.name]
						return item
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
				}),
			})
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		opts = {
			border_style = "rounded",
			saga_winblend = 10,
			lightbulb = {
				virtual_text = false,
			},
			beacon = {
				enable = false,
			},
			scroll_preview = {
				scroll_down = "<C-f>",
				scroll_up = "<C-b>",
			},
			symbol_in_winbar = {
				enable = true,
				separator = " -> ",
				hide_keyword = true,
				show_file = true,
				folder_level = 1,
				respect_root = false,
				color_mode = true,
			},
		},
		config = true,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
}
