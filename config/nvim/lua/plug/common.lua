return {
	"MunifTanjim/nui.nvim",
	"nvim-tree/nvim-web-devicons",
	{
    "goolord/alpha-nvim",
    init = function()
      if vim.fn.argc() == 0 then
        vim.cmd [[
        	autocmd UIEnter * :Alpha
        ]]
      end
    end,
    cmd = "Alpha",
    config = function ()
			require("plug.alpha")
		end,
    dependencies = "nvim-tree/nvim-web-devicons"
  },
	require('plug.editor'),
	require('plug.theme'),
	require('plug.lsp')
}
