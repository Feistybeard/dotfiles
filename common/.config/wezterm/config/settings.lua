local wezterm = require("wezterm")
local settings = {}
local opacity = 0.8

local handle = io.popen("uname")
if not handle then
	return
end

local system_name = handle:read("*a")
handle:close()
system_name = system_name:gsub("%s+", "")

function settings.setup(config)
	config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 1000 }
	-- ── Text ────────────────────────────────────────────────────────────
	config.window_frame = {
		font = wezterm.font({ family = "Hasklug Nerd Font Mono", weight = "Regular" }),
		font_size = 9,
	}
	config.font = wezterm.font({
		family = "Hasklug Nerd Font Mono",
		weight = "Medium",
		harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
	})
	config.font_rules = {
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				family = "Hasklug Nerd Font Mono",
				style = "Italic",
			}),
		},
	}
	config.font_size = 19
	config.line_height = 1.25
	config.underline_position = -6
	config.underline_thickness = "250%"

	-- ── UI ──────────────────────────────────────────────────────────────
	config.window_background_opacity = opacity
	config.macos_window_background_blur = 15
	if system_name == "Darwin" then
		config.window_decorations = "RESIZE"
	end
	config.hide_mouse_cursor_when_typing = true
	config.hide_tab_bar_if_only_one_tab = true
	config.use_fancy_tab_bar = true
	config.show_tab_index_in_tab_bar = true
	config.inactive_pane_hsb = {
		saturation = 0.4,
		brightness = 0.3,
	}
	config.colors = require("themes.cyberdream")

	-- ── Options ─────────────────────────────────────────────────────────
	config.use_dead_keys = false
	config.scrollback_lines = 5000
	config.adjust_window_size_when_changing_font_size = false
	config.window_padding = {
		left = 4,
		right = 4,
		top = 4,
		bottom = 1,
	}
	config.max_fps = 120
	config.animation_fps = 120
	config.front_end = "WebGpu"
	config.webgpu_power_preference = "HighPerformance"
	config.enable_kitty_graphics = true
	config.audible_bell = "Disabled"
end

return settings
