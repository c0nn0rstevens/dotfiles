
-- Pull in the Wezterm API
local wezterm = require("wezterm")


-- This will hold the configuration.
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 19
config.color_scheme = 'AdventureTime'
config.enable_tab_bar = false
-- config.window_background_image = 'Users/connor.stevens/.dotfiles/guts_cape.png'
config.window_background_opacity = 0.6
config.macos_window_background_blur = 90
config.window_background_image_hsb = {
  -- Darken the background image by reducing it to 1/3rd
  brightness = 0.5,

  -- You can adjust the hue by scaling its value.
  -- a multiplier of 1.0 leaves the value unchanged.
  hue = 1.0,

  -- You can adjust the saturation also.
  saturation = 1.0,
}
-- Start interactive shell at startup rather than login shell.
config.default_prog = {'/bin/zsh'}
-- Remove borders and tabs from Wezterm view, but leave the window resizeable.
config.window_decorations = "RESIZE"
return config

