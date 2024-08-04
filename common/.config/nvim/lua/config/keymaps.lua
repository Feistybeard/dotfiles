-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local utils = require("config.utils")
local keymap = utils.keymap

keymap("n", "<leader>U", ":UndotreeToggle<cr>", { desc = "Toggle Undotree" })
keymap("n", "<c-a>", "ggVG<c-$>", { desc = "Select all text" })
keymap("n", "n", "nzzzv", { desc = "Center screen after search for next" })
keymap("n", "N", "Nzzzv", { desc = "Center screen after search for previous" })
keymap("n", "<c-u>", "<c-u>zz", { desc = "Center screen after half page up" })
keymap("n", "<c-d>", "<c-d>zz", { desc = "Center screen after half page down" })

-- Package-info keymaps
keymap("n", "<leader>cp", "", { desc = "Package Info" })

keymap("n", "<leader>cpt", function()
  require("package-info").toggle()
end, { desc = "Toggle Package Info" })

keymap("n", "<leader>cpd", function()
  require("package-info").delete()
end, { silent = true, noremap = true, desc = "Delete package" })

keymap("n", "<leader>cpu", function()
  require("package-info").update()
end, { silent = true, noremap = true, desc = "Update package" })

keymap("n", "<leader>cpi", function()
  require("package-info").install()
end, { silent = true, noremap = true, desc = "Install package" })

keymap("n", "<leader>cpc", function()
  require("package-info").change_version()
end, { silent = true, noremap = true, desc = "Change package version" })

-- Fix for undos in insert mode
keymap("i", ",", ",<C-g>U", { desc = "Undo last change" })
keymap("i", ".", ".<C-g>U", { desc = "Undo last change" })
keymap("i", "!", "!<C-g>U", { desc = "Undo last change" })
keymap("i", "?", "?<C-g>U", { desc = "Undo last change" })

-- Open definition in a vertical split
keymap("n", "<leader>gd", function()
  utils.definition_split()
end, { desc = "Definition in vertical split" })

-- Diff files with from current/recent/git
keymap("n", "<leader>df", function()
  utils.telescope_diff_file()
end, { desc = "Diff file with current buffer" })
keymap("n", "<leader>dr", function()
  utils.telescope_diff_file(true)
end, { desc = "Diff recent file with current buffer" })
keymap("n", "<leader>dg", function()
  utils.telescope_diff_from_history()
end, { desc = "Diff from git history" })

-- Tmux navigator
local nvim_tmux_nav = require("nvim-tmux-navigation")
keymap(
  "n",
  "<C-h>",
  nvim_tmux_nav.NvimTmuxNavigateLeft,
  { desc = "Navigate left" }
)
keymap(
  "n",
  "<C-j>",
  nvim_tmux_nav.NvimTmuxNavigateDown,
  { desc = "Navigate down" }
)
keymap("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = "Navigate up" })
keymap(
  "n",
  "<C-l>",
  nvim_tmux_nav.NvimTmuxNavigateRight,
  { desc = "Navigate right" }
)
keymap(
  "n",
  "<C-\\>",
  nvim_tmux_nav.NvimTmuxNavigateLastActive,
  { desc = "Navigate last active" }
)

-- Tailwind fold
keymap(
  "n",
  "<leader>uc",
  ":TailwindFoldToggle<cr>",
  { desc = "Toggle tailwind fold" }
)

-- Remote SSHFS
keymap("n", "<leader>r", "", { desc = "remote" })
keymap(
  "n",
  "<leader>rc",
  ":RemoteSSHFSConnect<cr>",
  { desc = "Remote SSHFS Connect" }
)
keymap(
  "n",
  "<leader>rd",
  ":RemoteSSHFSDisconnect<cr>",
  { desc = "Remote SSHFS Disconnect" }
)
keymap(
  "n",
  "<leader>rf",
  ":RemoteSSHFSFindFiles<cr>",
  { desc = "Remote SSHFS File" }
)
keymap(
  "n",
  "<leader>rg",
  ":RemoteSSHFSLiveGrep<cr>",
  { desc = "Remote SSHFS Live Grep" }
)
keymap(
  "n",
  "<leader>rR",
  ":RemoteSSHFSReload<cr>",
  { desc = "Remote SSHFS Reload" }
)
keymap(
  "n",
  "<leader>re",
  ":RemoteSSHFSEdit<cr>",
  { desc = "Remote SSHFS Edit" }
)
