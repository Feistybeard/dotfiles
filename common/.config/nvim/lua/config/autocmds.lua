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

-- Run ObsidianTemplate command based on folder when creating daily/weekly notes
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.md" },
  callback = function()
    -- check if buffer/file is empty
    local function check_empty()
      if vim.api.nvim_buf_get_offset(0, 0) <= 0 then
        local handle = io.open(vim.api.nvim_buf_get_name(0))
        if handle == nil then
          return true
        end
        local eof = handle:read(0)
        handle:close()
        if eof == nil then
          return true
        end
      end
      return false
    end

    if check_empty() then
      local folder = vim.fn.expand("%:h")
      if folder == "00/daily" then
        vim.cmd("ObsidianTemplate daily")
      elseif folder == "00/weekly" then
        vim.cmd("ObsidianTemplate weekly")
      end
    end
  end,
})
