local wezterm = require("wezterm")
local Settings = {}

local handle = io.popen("uname")
if not handle then
	return
end
local system_name = handle:read("*a")
handle:close()
system_name = system_name:gsub("%s+", "")

function Settings.setup(config)
	config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 1000 }
	-- config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
	config.font = wezterm.font({ -- Normal text
		family = "Monaspace Neon",
		harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
		stretch = "UltraCondensed",
	})
	config.font_rules = {
		{ -- Italic
			intensity = "Normal",
			italic = true,
			font = wezterm.font({
				-- family = "Monaspace Radon", -- script style
				family = "Monaspace Xenon", -- courier-like
				style = "Italic",
			}),
		},
		{ -- Bold
			intensity = "Bold",
			italic = false,
			font = wezterm.font({
				family = "Monaspace Krypton",
				-- weight='ExtraBold',
				weight = "Bold",
			}),
		},
		{ -- Bold Italic
			intensity = "Bold",
			italic = true,
			font = wezterm.font({
				family = "Monaspace Xenon",
				style = "Italic",
				weight = "Bold",
			}),
		},
	}
	config.font_size = 14

	config.underline_position = -6
	config.underline_thickness = "250%"

	config.window_background_opacity = 0.86
	config.macos_window_background_blur = 20

	if system_name == "Darwin" then
		config.window_decorations = "RESIZE"
	end

	config.cursor_blink_rate = 600
	config.default_cursor_style = "BlinkingBlock"
	config.hide_mouse_cursor_when_typing = true

	config.use_dead_keys = false
	config.scrollback_lines = 5000
	config.adjust_window_size_when_changing_font_size = false
	config.hide_tab_bar_if_only_one_tab = true
	config.use_fancy_tab_bar = false
	config.show_tab_index_in_tab_bar = true

	config.inactive_pane_hsb = {
		saturation = 0.4,
		brightness = 0.3,
	}

	config.window_frame = {
		font = wezterm.font({ family = "Noto Sans", weight = "Regular" }),
		font_size = 9,
	}
	config.window_padding = {
		left = 30,
		right = 30,
		top = 40,
		bottom = 40,
	}

	config.max_fps = 120
	config.front_end = "WebGpu"
end

return Settings
