-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local indent = 4
local conceallevel = 2

vim.g.mapleader = " "
vim.g.maplocalleader = "/"

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.spell = true
opt.spelllang = { "en" }
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.swapfile = false
opt.confirm = true
opt.conceallevel = conceallevel
opt.cursorline = false
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.wrap = false
opt.iskeyword:remove("_")

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- LazyVim
vim.g.lazyvim_picker = "fzf"
vim.g.snacks_animate = true
