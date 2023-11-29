local go = {
	settings = {
		gopls = {
			gofumpt = true,
		},
	},
	on_attach = function()
		local goimpl = require("lazy.core.config").plugins["goimpl.nvim"]

		require("lazy.core.loader").load(goimpl, {})
		local function get_keys(t)
			local keys = ""
			for key, _ in pairs(t) do
				keys = keys .. " - " .. key
			end
			return keys
		end
		vim.cmd("echo \" " .. get_keys(goimpl) .."\"")
	end,
	flags = {
		debounce_text_changes = 150,
	},
}

return go
