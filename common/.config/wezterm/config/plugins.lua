local wezterm = require("wezterm")
local Plugins = {}

function Plugins.setup(_)
	-- Wezterm Session Manager
	-- local session_manager = require("wezterm-session-manager/session-manager")
	-- wezterm.on("save_session", function(window)
	-- 	session_manager.save_state(window)
	-- end)
	-- wezterm.on("load_session", function(window)
	-- 	session_manager.load_state(window)
	-- end)
	-- wezterm.on("restore_session", function(window)
	-- 	session_manager.restore_state(window)
	-- end)
end

return Plugins
