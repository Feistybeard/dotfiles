-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local general = augroup("General Settings", { clear = true })
local clear_on_save = augroup("Clean On Save", {})

-- Disable autoformat for markdown  files
autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Close specific buffers with q
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

-- Don't write comment on a new line
autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  group = general,
  desc = "Disable New Line Comment",
})

-- Remove trailing whitespace from all lines before saving a file
autocmd({ "BufWritePre" }, {
  group = clear_on_save,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Java/TypeScript formatting
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.js", "*.html", "*.css", "*.ts", "*.jsx", "*.tsx" },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
  end,
})

-- Run ObsidianTemplate command based on folder when creating new/daily/weekly notes
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
      elseif folder == "inbox" then
        vim.cmd("ObsidianTemplate note")
      end
    end
  end,
})

-- autocmd("BufWinEnter", {
--   callback = function(data)
--     utils.open_help(data.buf)
--   end,
--   group = general,
--   desc = "Redirect help to floating window",
-- })
