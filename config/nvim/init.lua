if vim.loader then
    vim.loader.enable()
end

-- Cache dir
local cache_dir = vim.fn.stdpath('config') .. '/cache'

if vim.fn.isdirectory(cache_dir) ~= 1 then
  vim.fn.mkdir(cache_dir, 'p')
end

-- Configs
require("core.baseconf")
require("core.keymaps")
require("plug.lazy")
