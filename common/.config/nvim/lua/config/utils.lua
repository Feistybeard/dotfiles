local M = {}

--- Get highlight properties for a given highlight name
--- @param name string The highlight group name
--- @param fallback? table The fallback highlight properties
--- @return table properties # the highlight group properties
function M.get_hlgroup(name, fallback)
  if vim.fn.hlexists(name) == 1 then
    local group = vim.api.nvim_get_hl(0, { name = name })

    local hl = {
      fg = group.fg == nil and "NONE" or M.parse_hex(group.fg),
      bg = group.bg == nil and "NONE" or M.parse_hex(group.bg),
    }

    return hl
  end
  return fallback or {}
end

-- Utility function that closes any floating windows when you press escape
function M.close_floating()
  for _, win in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == "win" then
      vim.api.nvim_win_close(win, false)
    end
  end
end

--- Parse a given integer color to a hex value.
--- @param int_color number
function M.parse_hex(int_color)
  return string.format("#%x", int_color)
end

--- Map a key combination to a command
---@param modes string|string[]: The mode(s) to map the key combination to
---@param lhs string: The key combination to map
---@param rhs string|function: The command to run when the key combination is pressed
---@param opts table: Options to pass to the keymap
function M.keymap(modes, lhs, rhs, opts)
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

-- Go to definition (in a split)
function M.definition_split()
  vim.lsp.buf.definition({
    on_list = function(options)
      -- if there are multiple items, warn the user
      if #options.items > 1 then
        vim.notify("Multiple items found, opening first one", vim.log.levels.WARN)
      end

      -- Open the first item in a vertical split
      local item = options.items[1]
      local cmd = "vsplit +" .. item.lnum .. " " .. item.filename .. "|" .. "normal " .. item.col .. "|"

      vim.cmd(cmd)
    end,
  })
end

-- Preserve cursor position on paste and move to the new line
function PreserveCursorPositionPaste()
  local cursor_save = vim.fn.getpos(".")
  local column = vim.fn.col(".")

  vim.cmd("normal! p")
  vim.cmd("normal! j")
  vim.fn.setpos(".", { 0, cursor_save[2] + 1, column, 0 })
end
vim.api.nvim_create_user_command("PastePreserveCursor", function()
  PreserveCursorPositionPaste()
end, {})

-- Godot Stuff
local paths_to_check = { "/", "/../" }
local is_godot_project = false
local godot_project_path = ""
local cwd = vim.fn.getcwd()
local lspconfig = require("lspconfig")

for key, value in pairs(paths_to_check) do
  if vim.uv.fs_stat(cwd .. value .. "project.godot") then
    is_godot_project = true
    godot_project_path = cwd .. value
    break
  end
end

local is_server_running = vim.uv.fs_stat(godot_project_path .. "/server.pipe")
if is_godot_project and not is_server_running then
  vim.fn.serverstart(godot_project_path .. "/server.pipe")
end

if is_godot_project then
  lspconfig.gdscript.setup({})
end

-- Godot debug config
---- write breakpoint to new line
vim.api.nvim_create_user_command("GodotBreakpoint", function()
  vim.cmd("normal! obreakpoint")
  vim.cmd("write")
end, {})
vim.keymap.set("n", "<leader>Gb", ":GodotBreakpoint<CR>")
---- delete all breakpoints in current file
vim.api.nvim_create_user_command("GodotDeleteBreakpoints", function()
  vim.cmd("g/breakpoint/d")
end, {})
vim.keymap.set("n", "<leader>GBD", ":GodotDeleteBreakpoints<CR>")
--- search all breakpoints in project
vim.api.nvim_create_user_command("GodotFindBreakpoints", function()
  vim.cmd(":grep breakpoint | copen")
end, {})
vim.keymap.set("n", "<leader>GBF", ":GodotFindBreakpoints<CR>")

return M
