local wezterm = require("wezterm")
local act = wezterm.action
local nvim_path = "/home/linuxbrew/.linuxbrew/bin/nvim"

local Keybinds = {}

-- Helper functions for keybinds
local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}
local function is_vim(pane)
	-- this is set by smart-splits.nvim Neovim plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

function Keybinds.setup(config)
	config.keys = {
		-- -- move between split panes
		-- split_nav("move", "h"),
		-- split_nav("move", "j"),
		-- split_nav("move", "k"),
		-- split_nav("move", "l"),
		-- -- resize panes
		-- split_nav("resize", "h"),
		-- split_nav("resize", "j"),
		-- split_nav("resize", "k"),
		-- split_nav("resize", "l"),
		{
			mods = "LEADER",
			key = "-",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "LEADER",
			key = "=",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "c",
			mods = "LEADER",
			action = act.CloseCurrentPane({ confirm = true }),
		},
		-- zoom pane
		{
			mods = "LEADER",
			key = "f",
			action = act.TogglePaneZoomState,
		},
		{
			mods = "LEADER",
			key = "Space",
			action = act.RotatePanes("Clockwise"),
		},
		{
			mods = "LEADER",
			key = "0",
			action = act.PaneSelect({ mode = "SwapWithActive" }),
		},
		{
			mods = "LEADER",
			key = "Enter",
			action = act.ActivateCopyMode,
		},
		{
			key = "t",
			mods = "LEADER",
			action = act.ShowTabNavigator,
		},
		{
			key = "r",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Rename tab",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = ",",
			mods = "LEADER",
			action = act.SpawnCommandInNewTab({
				cwd = os.getenv("WEZTERM_CONFIG_DIR"),
				set_environment_variables = {
					TERM = "screen-256color",
				},
				args = {
					-- TODO: make this check OS running for correct path
					nvim_path,
					os.getenv("WEZTERM_CONFIG_FILE"),
				},
			}),
		},
		{
			key = "p",
			mods = "LEADER",
			action = act.ShowLauncherArgs({
				flags = "FUZZY|COMMANDS",
			}),
		},
		{
			key = "w",
			mods = "LEADER",
			action = act.ShowLauncherArgs({
				flags = "WORKSPACES",
			}),
		},
		{
			key = "F2",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Text = "Rename workspace " .. wezterm.mux.get_active_workspace() },
				}),
				action = wezterm.action_callback(function(_, _, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
		{ key = "S", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_session" }) },
		{ key = "L", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_session" }) },
		{ key = "R", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_session" }) },
		{
			key = "W",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "New Workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_action(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
		{ key = "PageUp",   mods = "SHIFT", action = act.ScrollByPage(-0.5) },
		{ key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(0.5) },
	}
	for i = 1, 9 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = act.ActivateTab(i - 1),
		})
	end
end

return Keybinds
