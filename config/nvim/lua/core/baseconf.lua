vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
vim.opt.encoding = "utf-8"
vim.opt.sw = 2
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.mouse = "a"
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.inccommand = "nosplit"
vim.opt.hidden = true

vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

vim.cmd("syntax on")

vim.g.mapleader="."
vim.g["rainbow#pairs"] = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
