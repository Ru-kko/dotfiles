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
			},
			styles = {
				booleans = { "bold", "italic" },
			},
		},
		config = function(_, opts)
			vim.cmd [[colorscheme catppuccin]]
			require("catppuccin").setup(opts)
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
		lazy = false,
		config = function()
			vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])

			vim.opt.list = true
			vim.opt.listchars:append("space:⋅")

			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
			})
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
