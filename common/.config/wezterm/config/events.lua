local wezterm = require("wezterm")
local functions = require("config.functions")
local Events = {}

function Events.setup(_)
	-- wezterm.on("format-tab-title", function(tab)
	-- 	local has_unseen_output = false
	-- 	local is_zoomed = false
	-- 	for _, pane in ipairs(tab.panes) do
	-- 		if pane.has_unseen_output then
	-- 			has_unseen_output = true
	-- 		end
	-- 		if pane.is_zoomed then
	-- 			is_zoomed = true
	-- 		end
	-- 	end
	--
	-- 	local process = functions.get_process(tab)
	-- 	local zoom_icon = is_zoomed and wezterm.nerdfonts.cod_zoom_in or ""
	-- 	local title = string.format("  %s%s ", process, zoom_icon)
	--
	-- 	local formatted_title = wezterm.format({
	-- 		{ Attribute = { Intensity = "Bold" } },
	-- 		{ Text = title },
	-- 	})
	-- 	if has_unseen_output then
	-- 		return {
	-- 			{ Foreground = { Color = "#28719c" } },
	-- 			{ Text = formatted_title },
	-- 		}
	-- 	else
	-- 		return {
	-- 			{ Text = formatted_title },
	-- 		}
	-- 	end
	-- end)
	--
	-- wezterm.on("update-status", function(window, pane)
	-- 	local workspace_or_leader = window:active_workspace()
	-- 	if window:active_key_table() then
	-- 		workspace_or_leader = window:active_key_table()
	-- 	end
	-- 	if window:leader_is_active() then
	-- 		workspace_or_leader = "LEADER"
	-- 	end
	--
	-- 	local cmd = functions.get_last_folder_segment(pane:get_foreground_process_name())
	-- 	-- local time = wezterm.strftime("%H:%M")
	-- 	local hostname = " " .. wezterm.hostname() .. " "
	--
	-- 	window:set_right_status(wezterm.format({
	-- 		{ Foreground = { Color = "FFB86C" } },
	-- 		{ Text = wezterm.nerdfonts.oct_table .. " " .. workspace_or_leader },
	-- 		"ResetAttributes",
	-- 		{ Text = " | " },
	-- 		{ Text = wezterm.nerdfonts.fa_code .. " " .. cmd },
	-- 		{ Text = " | " },
	-- 		{ Text = wezterm.nerdfonts.oct_person .. "" .. hostname },
	-- 		-- { Text = " | " },
	-- 		-- { Text = wezterm.nerdfonts.md_clock .. " " .. time },
	-- 		-- { Text = " | " },
	-- 	}))
	-- end)
end

return Events
