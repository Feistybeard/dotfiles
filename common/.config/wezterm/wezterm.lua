local keybinds = require("config.keybinds")
local plugins = require("config.plugins")
local events = require("config.events")
local settings = require("config.settings")

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- local theme = require("themes.pine").main
-- config.colors = theme.colors()
config.color_scheme = "Modus-Vivendi-Tritanopia"

keybinds.setup(config)
plugins.setup(config)
events.setup(config)
settings.setup(config)

return config
