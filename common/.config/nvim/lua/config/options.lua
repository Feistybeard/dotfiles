-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
local indent = 4
local conceallevel = 2

opt.scrolloff = 8
opt.sidescrolloff = 8
opt.tabstop = indent
opt.softtabstop = indent
opt.shiftwidth = indent
opt.swapfile = false
opt.confirm = true
opt.conceallevel = conceallevel
opt.relativenumber = false
opt.cursorline = false
