local servers = {
	"lua_ls",
	"jdtls",
	"tsserver",
	"emmet_ls",
	"hls",
	"cssls",
	"html",
	"dockerls",
	"docker_compose_language_service",
	"eslint",
	"sqlls",
	"gopls",
	"html",
	"csharp_ls",
	"phpactor",
	"yamlls",
}

local function attach_keys(_, buf)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(buf, ...)
	end
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
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
				gopls = require("langs.golang"),
				tsserver = {
					on_attach = function(client)
						client.resolved_capabilities.document_formatting = false
					end,
				},
			},
		},
		config = function(_, opts)
			local capabilities =
					require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local function setup(server)
				local svconf = opts.servers[server] or {}

				svconf.capabilities = vim.deepcopy(capabilities)
				if svconf.on_attach ~= nil then
					local oldfn = svconf.on_attach
					svconf.on_attach = function(...)
						oldfn(...)
						attach_keys(...)
					end
				else
					svconf.on_attach = attach_keys
				end

				require("lspconfig")[server].setup(svconf or {})
			end

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				handlers = { setup },
			})
		end,
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neodev.nvim", opts = {} },
		},
	},
	{
		"williamboman/mason.nvim",
		config = true,
		cmd = {
			"Mason",
			"MasonInstall",
			"MasonUninstall",
			"MasonUninstallAll",
			"MasonLog",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local defaults = require("cmp.config.default")()
			local cmp = require("cmp")
			---@diagnostic disable-next-line: missing-fields
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
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<Tab>"] = cmp.mapping(function(fallback)
						local col = vim.fn.col(".") - 1
						if cmp.visible() then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
							fallback()
						else
							cmp.complete()
						end
					end, { "i", "s" }),
				}),
				---@diagnostic disable-next-line: missing-fields
				formatting = {
					fields = { "menu", "abbr", "kind" },
					format = require("lspkind").cmp_format({ maxwidth = 50, mode = "symbol_text", ellipsis_char = "..." }),
				},
				sorting = defaults.sorting,
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer" },
				}),
			})
		end,
		dependencies = {
			"onsails/lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				opts = {
					history = true,
					delete_check_events = "TextChanged",
				},
				dependencies = {
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
			},
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
