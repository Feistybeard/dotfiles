-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local utils = require("config.utils")
local opts = { noremap = true, silent = true }
local keymap = utils.keymap

keymap({ "n", "v" }, "<leader>c1", ":CBllbox<cr>", { desc = "Comment - left box" })
keymap({ "n", "v" }, "<leader>c2", ":CBccbox<cr>", { desc = "Comment - center box" })
keymap({ "n", "v" }, "<leader>c3", ":CBllline<cr>", { desc = "Comment - left line" })
keymap({ "n", "v" }, "<leader>c4", ":CBccline<cr>", { desc = "Comment - center line" })

keymap("i", "<A-h>", "<Left>", { desc = "Move left in insert mode" })
keymap("i", "<A-l>", "<Right>", { desc = "Move right in insert mode" })
keymap("i", "<A-j>", "<Down>", { desc = "Move down in insert mode" })
keymap("i", "<A-k>", "<Up>", { desc = "Move up in insert mode" })

keymap("i", "jk", "<Esc>", opts)
keymap("n", "<c-a>", "ggVG<c-$>", { desc = "Select all text" })
keymap("n", "<esc>", function()
  utils.close_floating()
  vim.cmd(":noh")
end, { silent = true, desc = "Remove Search Highlighting, Dismiss Popups" })

-- Fix for undos in insert mode
keymap("i", ",", ",<C-g>U", { desc = "Undo last change" })
keymap("i", ".", ".<C-g>U", { desc = "Undo last change" })
keymap("i", "!", "!<C-g>U", { desc = "Undo last change" })
keymap("i", "?", "?<C-g>U", { desc = "Undo last change" })

-- Open definition in a vertical split
keymap("n", "<leader>gd", function()
  utils.definition_split()
end, { desc = "Definition in vertical split" })

-- Plugins
---- FzfLua
keymap("n", "<leader>xs", require("fzf-lua").spell_suggest, { desc = "Spelling Suggestions" })
---- Undotree
keymap("n", "<leader>U", ":UndotreeToggle<cr>", { desc = "Toggle Undotree" })
---- Tailwind fold
keymap("n", "<leader>uw", ":TailwindFoldToggle<cr>", { desc = "Toggle tailwind fold" })
---- Remote SSHFS
keymap("n", "<leader>r", "", { desc = "remote" })
keymap("n", "<leader>rc", ":RemoteSSHFSConnect<cr>", { desc = "Remote SSHFS Connect" })
keymap("n", "<leader>rd", ":RemoteSSHFSDisconnect<cr>", { desc = "Remote SSHFS Disconnect" })
keymap("n", "<leader>rf", ":RemoteSSHFSFindFiles<cr>", { desc = "Remote SSHFS File" })
keymap("n", "<leader>rg", ":RemoteSSHFSLiveGrep<cr>", { desc = "Remote SSHFS Live Grep" })
keymap("n", "<leader>rR", ":RemoteSSHFSReload<cr>", { desc = "Remote SSHFS Reload" })
keymap("n", "<leader>re", ":RemoteSSHFSEdit<cr>", { desc = "Remote SSHFS Edit" })
---- Mini.files
keymap("n", "<leader>e", function()
  require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end, { desc = "Open mini.files (Directory of Current File)" })
keymap("n", "<leader>E", function()
  require("mini.files").open(vim.uv.cwd(), true)
end, { desc = "Open mini.files (cwd)" })
