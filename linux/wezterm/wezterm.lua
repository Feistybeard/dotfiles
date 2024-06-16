local keybinds = require("config.keybinds")
local plugins = require("config.plugins")
local events = require("config.events")
local settings = require("config.settings")

local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

keybinds.setup(config)
plugins.setup(config)
events.setup(config)
settings.setup(config)

return config
