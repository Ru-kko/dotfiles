return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		cmd = {
			"Telescope",
		},
		keys = {
			{
				"<leader>tt",
				function()
					require("telescope.builtin").find_files({
						cwd = vim.loop.cwd(),
						hidden = true,
						no_ignore = true,
						no_ignore_parent = true,
					})
				end,
				desc = "Find Plugin File",
			},
			{
				"<leader>tf",
				function()
					require("telescope.builtin").live_grep()
				end,
			},
			{
				"<C-t>",
				function ()
					require("telescope").extensions.file_browser.file_browser({
						hidden = true,
						respect_gitignore = false,
						no_ignore = true,
					})
				end,
				mode = { "n", "v", "i" },
			},
			{
				"<A-t>",
				"<cmd>:Telescope file_browser path=%:p:h select_buffer=true<CR>",
				mode = { "n", "v", "i" },
			},
			{ "<leader>sh",  "<cmd>Telescope help_tags<cr>",   desc = "Help Pages" },
			{ "<leader>gcm", "<cmd>Telescope git_commits<CR>", desc = "commits" },
			{ "<leader>gs",  "<cmd>Telescope git_status<CR>",  desc = "status" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--no-ignore",
						"--hidden"
					},
					prompt_prefix = " ",
					selection_caret = " ",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					file_ignore_patterns = {
						"node_modules",
						"pnpm-lock.yaml",
						".git/",
					},
					path_display = { "absolute" },
					sorting_strategy = "ascending",
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					use_less = true,
					set_env = { ["COLORTERM"] = "truecolor" },
				},
				pickers = {
					find_files = {
						theme = "dropdown",
						hidden = true,
					},
				},
				extensions = {
					media_files = {
						filetypes = { "png", "webp", "jpg", "jpeg" },
						find_cmd = "rg",
					},
					file_browser = {
						theme = "dropdown",
						hidden = { file_browser = true, folder_browser = true },
						hijack_netrw = true,
						mappings = {
							["i"] = {},
							["n"] = {},
						},
					},
				},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-lua/popup.nvim",
			{
				"nvim-telescope/telescope-file-browser.nvim",
				config = function()
					require("telescope").load_extension("file_browser")
				end,
			},
			{
				"nvim-telescope/telescope-media-files.nvim",
				config = function()
					require("telescope").load_extension("media_files")
				end,
			},
		},
	},
	-- GOIMPL will lazy load only when golang lsp is attached
	{
		"edolphin-ydf/goimpl.nvim",
		keys = {
			{
				"mp",
				function()
					require("telescope").extensions.goimpl.goimpl({})
				end,
				silent = true,
				desc = "Golang implemnt",
			},
		},
		config = function()
			require("telescope").load_extension("goimpl")
		end,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
}
