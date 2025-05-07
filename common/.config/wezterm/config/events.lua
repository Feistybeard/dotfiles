local wezterm = require("wezterm")
local events = {}

function events.setup(config)
	-- ── Tab Formatting ──────────────────────────────────────────────────
	wezterm.on("format-tab-title", function(tab, _, _, _, hover)
		local background = config.colors.brights[1]
		local foreground = config.colors.foreground

		if tab.is_active then
			background = config.colors.brights[7]
			foreground = config.colors.background
		elseif hover then
			background = config.colors.brights[8]
			foreground = config.colors.background
		end

		local title = tostring(tab.tab_index + 1)
		return {
			{ Foreground = { Color = background } },
			{ Text = "█" },
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = title },
			{ Foreground = { Color = background } },
			{ Text = "█" },
		}
	end)
	-- ── Toggle opacity with leader+o ────────────────────────────────────
	wezterm.on("toggle-opacity", function(window, pane)
		local overrides = window:get_config_overrides() or {}
		if not overrides.window_background_opacity then
			overrides.window_background_opacity = 1
		else
			overrides.window_background_opacity = nil
		end
		window:set_config_overrides(overrides)
	end)
end

return events
