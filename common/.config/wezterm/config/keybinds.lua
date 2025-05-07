local wezterm = require("wezterm")
local act = wezterm.action
local keybinds = {}

function keybinds.setup(config)
	config.keys = {
		{
			mods = "LEADER",
			key = "v",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			mods = "LEADER",
			key = "s",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "c",
			mods = "LEADER",
			action = act.CloseCurrentPane({ confirm = true }),
		},
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
			action = act.PaneSelect({ mode = "SwapWithActive", alphabet = "123456789" }),
		},
		{
			mods = "LEADER",
			key = "h",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			mods = "LEADER",
			key = "]",
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
		{
			key = "o",
			mods = "LEADER",
			action = wezterm.action.EmitEvent("toggle-opacity"),
		},
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
		{ key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-0.5) },
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

return keybinds
