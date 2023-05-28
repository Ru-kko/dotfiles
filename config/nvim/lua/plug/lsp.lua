local servers = {
	"lua_ls",
	"jdtls",
	"tsserver",
	"emmet_ls"
}

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
				}
			}
		},
		config = function(_,opts)
			local lspconfig = require('lspconfig')
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
  			'force',
  			lspconfig.util.default_config.capabilities,
				capabilities
			)

			for _, server in pairs(servers) do
				local sv = lspconfig[server]
				if sv.capabilities == nil then
					sv.capabilities = capabilities
				end
				sv.setup(opts.servers[server] or {})
			end
		end,
		dependencies = {
			"hrsh7th/nvim-cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "folke/neodev.nvim", opts = {} }
		}
	},
	{
		"williamboman/mason.nvim",
		cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog"
    },
		dependencies = {
			"williamboman/mason-lspconfig.nvim"
		}
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = servers
		},
		config = function ()
			require("mason").setup()
			require("mason-lspconfig").setup()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim"
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
          expand = function (args)
						require('luasnip').lsp_expand(args.body)
        	end
        },
				window = {
          documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered()
        },
				mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
        	['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        formatting = {
					fields = {'menu', 'abbr', 'kind'},
					format = function(entry, item)
						local menu_icon = {
							nvim_lsp = 'λ',
							vsnip = '⋗',
							buffer = 'Ω',
							path = '🖫',
						}
						item.menu = menu_icon[entry.source.name]
						return item
					end
				},
				sources = cmp.config.sources({
			    { name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'buffer' },
				})
			})
		end,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		}
	},
}
