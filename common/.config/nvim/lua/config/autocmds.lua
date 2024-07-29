-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local utils = require("config.utils")

local general = augroup("General Settings", { clear = true })
local clear_on_save = augroup("CleanOnSave", {})

autocmd("BufWinEnter", {
  callback = function(data)
    utils.open_help(data.buf)
  end,
  group = general,
  desc = "Redirect help to floating window",
})

autocmd("FileType", {
  group = general,
  pattern = {
    "grug-far",
    "help",
    "checkhealth",
    "copilot-chat",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})

autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})

autocmd({ "BufWritePre" }, {
  group = clear_on_save,
  pattern = "*",
  command = [[%s/\s\+$//e]],
}) -- remove trailing whitespace from all lines before saving a file)

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.js", "*.html", "*.css", "*.ts", "*.jsx", "*.tsx" },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
  end,
}) -- javascript/ts formatting

-- autocmd("BufReadPost", {
--   command = "silent lua require('guess-indent').set_from_buffer('auto_cmd')",
-- })
