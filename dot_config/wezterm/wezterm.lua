-- WezTerm
-- https://wezfurlong.org/wezterm/

local wezterm = require 'wezterm'

return {
	window_close_confirmation = 'NeverPrompt',
	exit_behavior = 'Close',

	audible_bell = 'Disabled',

	-- Smart tab bar [distraction-free mode]
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,

	window_padding = {
  	left = 3, right = 3,
  	top = 3, bottom = 3,
  },

	-- Color scheme
	-- https://wezfurlong.org/wezterm/colorschemes/index.html
	color_scheme = 'Wez',

	window_background_opacity = 0.95,

	-- Font configuration
	-- https://wezfurlong.org/wezterm/config/fonts.html
	font = wezterm.font('Iosevka Nerd Font'),
	font_size = 14.0,

	-- Cursor style
	default_cursor_style = 'BlinkingBlock',

	native_macos_fullscreen_mode = true,

	check_for_updates = true,
	check_for_updates_interval_seconds = 86400,
	show_update_window = true,
}
