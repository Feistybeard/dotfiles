-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local k = require("config.utils")

local utils = require("config.utils")

--- Map a key combination to a command
---@param modes string|string[]: The mode(s) to map the key combination to
---@param lhs string: The key combination to map
---@param rhs string|function: The command to run when the key combination is pressed
---@param opts table: Options to pass to the keymap
local map = function(modes, lhs, rhs, opts)
  local options = { silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  if type(modes) == "string" then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    vim.keymap.set(mode, lhs, rhs, options)
  end
end

k.set_keymap("n", "<leader>bb", ":Telescope buffers<cr>", { desc = "Buffers" })
k.set_keymap(
  "n",
  "<leader>U",
  ":UndotreeToggle<cr>",
  { desc = "Toggle Undotree" }
)
k.set_keymap("n", "<c-a>", "ggVG<c-$>", { desc = "Select all text" })
k.set_keymap(
  "n",
  "n",
  "nzzzv",
  { desc = "Center screen after search for next" }
)
k.set_keymap(
  "n",
  "N",
  "Nzzzv",
  { desc = "Center screen after search for previous" }
)
k.set_keymap(
  "n",
  "<c-u>",
  "<c-u>zz",
  { desc = "Center screen after half page up" }
)
k.set_keymap(
  "n",
  "<c-d>",
  "<c-d>zz",
  { desc = "Center screen after half page down" }
)
-- Package-info keymaps
k.set_keymap("n", "<leader>cp", "", { desc = "Package Info" })
k.set_keymap(
  "n",
  "<leader>cpt",
  "<cmd>lua require('package-info').toggle()<cr>",
  { desc = "Toggle Package Info" }
)
k.set_keymap(
  "n",
  "<leader>cpd",
  "<cmd>lua require('package-info').delete()<cr>",
  { silent = true, noremap = true, desc = "Delete package" }
)
k.set_keymap(
  "n",
  "<leader>cpu",
  "<cmd>lua require('package-info').update()<cr>",
  { silent = true, noremap = true, desc = "Update package" }
)
k.set_keymap(
  "n",
  "<leader>cpi",
  "<cmd>lua require('package-info').install()<cr>",
  { silent = true, noremap = true, desc = "Install package" }
)
k.set_keymap(
  "n",
  "<leader>cpc",
  "<cmd>lua require('package-info').change_version()<cr>",
  { silent = true, noremap = true, desc = "Change package version" }
)

k.set_keymap("i", ",", ",<C-g>U", { desc = "Undo last change" })
k.set_keymap("i", ".", ".<C-g>U", { desc = "Undo last change" })
k.set_keymap("i", "!", "!<C-g>U", { desc = "Undo last change" })
k.set_keymap("i", "?", "?<C-g>U", { desc = "Undo last change" })

-- Open definition in a vertical split
k.set_keymap(
  "n",
  "<leader>gd",
  "<cmd>lua require('config.utils').definition_split()<cr>",
  { desc = "Definition in vertical split" }
)

-- stylua: ignore start
map("n", "<leader>df", function() utils.telescope_diff_file() end, { desc = "Diff file with current buffer" })
map("n", "<leader>dr", function() utils.telescope_diff_file(true) end, { desc = "Diff recent file with current buffer" })
map("n", "<leader>dg", function() utils.telescope_diff_from_history() end, { desc = "Diff from git history" })
-- stylua: ignore end
