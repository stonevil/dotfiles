-- WezTerm
-- https://wezfurlong.org/wezterm/

local wezterm = require("wezterm")

local function is_vi_process(pane)
	return pane:get_foreground_process_name():find("n?vim") ~= nil
end

return {
	window_close_confirmation = "NeverPrompt",
	exit_behavior = "Close",

	audible_bell = "Disabled",

	-- Smart tab bar [distraction-free mode]
	show_new_tab_button_in_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = false,

	window_padding = {
		left = "1cell",
		right = "1cell",
		top = "0.5cell",
		bottom = "0.5cell",
	},

	-- iTerm colours for reference
	-- https://github.com/mbadolato/iTerm2-Color-Schemes
	color_schemes = {
		["stoned"] = {
			foreground = "#c9c9c9",
			background = "black",
			cursor_bg = "#c9c9c9",
			cursor_border = "#c9c9c9",
			cursor_fg = "#141414",
			selection_bg = "#141414",
			selection_fg = "#c9c9c9",

			ansi = { "#191918", "#b34538", "#587744", "#d08949", "#206ec5", "#864651", "#ac9166", "#f1eee7" },
			brights = { "#2c2b2a", "#b33323", "#42824a", "#c75a22", "#5389c5", "#e795a5", "#ebc587", "#ffffff" },
		},
		["ayu1"] = {
			foreground = "#e6e1cf",
			background = "black",
			cursor_bg = "#f29718",
			cursor_border = "#f29718",
			cursor_fg = "#e6e1cf",
			selection_bg = "#253340",
			selection_fg = "#e6e1cf",

			ansi = { "#000000", "#ff3333", "#b8cc52", "#e7c547", "#36a3d9", "#f07178", "#95e6cb", "#ffffff" },
			brights = { "#323232", "#ff6565", "#eafe84", "#fff779", "#68d5ff", "#ffa3aa", "#c7fffd", "#ffffff" },
		},
		["nordish"] = {
			foreground = "#d8dee9",
			background = "black",
			cursor_bg = "#eceff4",
			cursor_border = "#eceff4",
			cursor_fg = "#282828",
			selection_bg = "#eceff4",
			selection_fg = "#4c566a",

			ansi = { "#3b4252", "#bf616a", "#a3be8c", "#ebcb8b", "#81a1c1", "#b48ead", "#88c0d0", "#e5e9f0" },
			brights = { "#4c566a", "#bf616a", "#a3be8c", "#ebcb8b", "#81a1c1", "#b48ead", "#8fbcbb", "#eceff4" },
		},
	},

	-- Color scheme
	-- https://wezfurlong.org/wezterm/colorschemes/index.html
	color_scheme = "nordish",
	-- color_scheme = "AyuDark (Gogh)",
	-- color_scheme = "Brewer (base16)",
	-- color_scheme = "Hacktober", -- (!)
	-- color_scheme = "Iiamblack (terminal.sexy)",

	window_background_opacity = 1.0,
	window_decorations = "RESIZE",

	enable_scroll_bar = false,

	native_macos_fullscreen_mode = true,

	enable_wayland = true,

	initial_cols = 140,
	initial_rows = 50,
	inactive_pane_hsb = {
		saturation = 0.6,
		brightness = 0.6,
	},

	-- Font configuration
	-- https://wezfurlong.org/wezterm/config/fonts.html
	font = wezterm.font("Iosevka Nerd Font"),
	font_size = 15.0,
	max_fps = 120,
	line_height = 1.1,

	-- Cursor style
	default_cursor_style = "BlinkingBlock",

	check_for_updates = true,
	-- check_for_updates_interval_seconds = 86400,
	show_update_window = true,

	disable_default_key_bindings = true,
	pane_focus_follows_mouse = false,

	send_composed_key_when_left_alt_is_pressed = true,
	keys = {
		{ key = "mapped:#", mods = "META", action = "DisableDefaultAssignment" },
		{ key = "mapped:≠", mods = "META", action = "DisableDefaultAssignment" },
		{ key = "mapped:€", mods = "META", action = "DisableDefaultAssignment" },
		{ key = "mapped:´", mods = "META", action = "DisableDefaultAssignment" },
		{ key = "mapped:…", mods = "META", action = "DisableDefaultAssignment" },
		{ key = "mapped:≈", mods = "META", action = "DisableDefaultAssignment" },

		{ key = "q", mods = "SUPER", action = "QuitApplication" },
		{ key = "w", mods = "SUPER", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },

		{ key = "t", mods = "SUPER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },

		{ key = "}", mods = "SUPER|SHIFT", action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ key = "{", mods = "SUPER|SHIFT", action = wezterm.action({ ActivateTabRelative = -1 }) },

		{ key = "f", mods = "SUPER|CTRL", action = wezterm.action.ToggleFullScreen },

		{ key = "m", mods = "SUPER", action = wezterm.action.Hide },
		{ key = "h", mods = "SUPER", action = wezterm.action.HideApplication },

		{ key = "\\", mods = "META", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
		{ key = "-", mods = "META", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{ key = "w", mods = "META", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },

		{ key = "LeftArrow", mods = "META|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "DownArrow", mods = "META|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "UpArrow", mods = "META|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "RightArrow", mods = "META|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },

		{ key = "LeftArrow", mods = "META", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "DownArrow", mods = "META", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "UpArrow", mods = "META", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "RightArrow", mods = "META", action = wezterm.action.ActivatePaneDirection("Right") },

		{ key = "z", mods = "META|SHIFT", action = wezterm.action.TogglePaneZoomState },

		{ key = "?", mods = "META|SHIFT", action = wezterm.action.ActivateCopyMode },

		{ key = "=", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },

		{ key = "v", mods = "SUPER", action = "Paste" },
		{ key = "c", mods = "SUPER", action = "Copy" },
	},
}
