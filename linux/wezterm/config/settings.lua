local wezterm = require("wezterm")
local Settings = {}

function Settings.setup(config)
	config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = 1000 }
	config.tab_max_width = 60
	-- config.color_scheme = "Hardcore"
	config.color_scheme = "Tokyo Night"
	config.font = wezterm.font("JetBrainsMono Nerd Font")
	config.font_size = 16

	config.window_background_opacity = 0.98
	-- config.window_decorations = "INTEGRATED_BUTTONS"
	config.cursor_blink_rate = 600
	config.default_cursor_style = "BlinkingBlock"
	config.hide_mouse_cursor_when_typing = true

	config.use_dead_keys = false
	config.scrollback_lines = 5000
	config.adjust_window_size_when_changing_font_size = false
	config.hide_tab_bar_if_only_one_tab = false
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
		left = 5,
		right = 5,
		top = 0,
		bottom = 0,
	}

	config.animation_fps = 120
	config.max_fps = 120

	config.front_end = "WebGpu"

	-- taken from https://github.com/enkia/tokyo-night-vscode-theme
	local primary_bg = "#24283b"

	local tab_bar_colors = {
		bg = primary_bg,
		active = {
			bg = primary_bg,
			fg = "#7aa2f7",
		},
		inactive = {
			bg = primary_bg,
			fg = "#565f89",
			hover = {
				bg = "#414868",
				fg = "#bdc7f0",
			},
		},
		new = {
			bg = primary_bg,
			fg = "#bdc7f0",
			hover = {
				bg = primary_bg,
				fg = "#cfc9c2",
			},
		},
	}

	config.colors = {
		tab_bar = {
			-- The color of the strip that goes along the top of the window
			-- (does not apply when fancy tab bar is in use)
			background = tab_bar_colors.bg,

			-- The active tab is the one that has focus in the window
			active_tab = {
				-- The color of the background area for the tab
				bg_color = tab_bar_colors.active.bg,
				-- The color of the text for the tab
				fg_color = tab_bar_colors.active.fg,

				-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
				-- label shown for this tab.
				-- The default is "Normal"
				intensity = "Bold",

				-- Specify whether you want "None", "Single" or "Double" underline for
				-- label shown for this tab.
				-- The default is "None"
				underline = "None",

				-- Specify whether you want the text to be italic (true) or not (false)
				-- for this tab.  The default is false.
				italic = false,

				-- Specify whether you want the text to be rendered with strikethrough (true)
				-- or not for this tab.  The default is false.
				strikethrough = false,
			},

			-- Inactive tabs are the tabs that do not have focus
			inactive_tab = {
				bg_color = tab_bar_colors.inactive.bg,
				fg_color = tab_bar_colors.inactive.fg,
				italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over inactive tabs
			inactive_tab_hover = {
				bg_color = tab_bar_colors.inactive.hover.bg,
				fg_color = tab_bar_colors.inactive.hover.fg,
				italic = false,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `inactive_tab_hover`.
			},

			-- The new tab button that let you create new tabs
			new_tab = {
				bg_color = tab_bar_colors.new.bg,
				fg_color = tab_bar_colors.new.fg,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab`.
			},

			-- You can configure some alternate styling when the mouse pointer
			-- moves over the new tab button
			new_tab_hover = {
				bg_color = tab_bar_colors.new.hover.bg,
				fg_color = tab_bar_colors.new.hover.fg,
				-- italic = true,

				-- The same options that were listed under the `active_tab` section above
				-- can also be used for `new_tab_hover`.
			},
		},
	}
end

return Settings
