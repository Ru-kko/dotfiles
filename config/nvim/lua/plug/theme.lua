return {
	-- Notify
	"rcarriga/nvim-notify",
	-- Status bar
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("plug.lualine")
		end,
	},
	-- Theme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 1000,
		opts = {
			transparent_background = false,
			term_colors = true,
			compile_path = vim.fn.stdpath("config") .. "/cache/catppuccin",
			integrations = {
				notify = false,
				mason = true,
				noice = true,
				lsp_trouble = true,
				indent_blankline = {
					enabled = true,
					colored_indent_levels = false,
				},
			},
			styles = {
				booleans = { "bold", "italic" },
				keywords = { "italic" },
				loops = { "italic" },
				operators = { "bold" },
				functions = { "italic" },
			},
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd([[colorscheme catppuccin]])
		end,
	},
	-- {
	--    "folke/tokyonight.nvim",
	--    lazy = false,
	--    priority = 1000,
	--    config = function()
	--      vim.cmd [[colorscheme tokyonight-night ]]
	--    end
	--  },
	-- Indent line
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")

			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({
				scope = { highlight = highlight }
			})

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
	-- Command line
	{
		"folke/noice.nvim",
		opts = {
			dependencies = {
				"MunifTanjim/nui.nvim",
				"nvim-tree/nvim-web-devicons",
				"nvim-treesitter/nvim-treesitter",
				{
					"rcarriga/nvim-notify",
					keys = {
						{
							"<leader>rm",
							function()
								require("notify").dismiss({ silent = true, pending = true })
							end,
							desc = "Delete all Notifications",
						},
					},
					opts = {
						background_colour = "#000000",
						timeout = 3000,
						max_height = function()
							return math.floor(vim.o.lines * 0.5)
						end,
						max_width = function()
							return math.floor(vim.o.columns * 0.5)
						end,
					},
				},
			},
			ls = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
	},
}
