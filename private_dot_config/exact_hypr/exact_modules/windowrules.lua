-- Virt
hl.window_rule({
	name = "Virt",
	match = {
		class = "(org.gnome.Boxes|org.kde.karton|virt-manager)",
	},
	workspace = "7",
	float = true,
	size = "(monitor_w*0.6) (monitor_h*0.8)",
})

-- ROG
hl.window_rule({
	name = "ROG",
	match = {
		class = "^(rog-control-center)$",
	},
	workspace = "7",
	float = true,
	center = true,
})

-- Browsers
hl.window_rule({
	name = "Browsers",
	match = {
		class = "^(librewolf|chromium|helium)$",
	},
	workspace = "2",
	size = "(monitor_w*0.7) (monitor_h)",
})

-- MPV
hl.window_rule({
	name = "MPV",
	match = {
		class = "^(mpv)$",
	},
	float = true,
	center = true,
})

-- Discord
hl.window_rule({
	name = "Discord",
	match = {
		class = "^(discord)$",
	},
	workspace = "3",
})

-- OpenSnitch
hl.window_rule({
	name = "OpenSnitch",
	match = {
		class = "opensnitch_ui",
	},
	float = true,
	size = "(monitor_w*0.7) (monitor_h*0.7)",
})

-- Terminal
hl.window_rule({
	name = "Terminals",
	match = {
		class = "^(Alacritty|foot|kitty|wezterm|com.mitchellh.ghostty)$",
	},
	opacity = 0.9,
})

-- Polkit
hl.window_rule({
	name = "Polkit",
	match = {
		class = "(org.kde.polkit-kde-authentication-agent-1)",
	},
	float = true,
	center = true,
})

-- Pavucontrol
hl.window_rule({
	name = "Pavucontrol",
	match = {
		class = "pavucontrol",
	},
	center = true,
	float = true,
})

-- KRDC
hl.window_rule({
	name = "KRDC",
	match = {
		class = "(org.kde.krdc)",
	},
	workspace = "6",
})

-- KCalc
hl.window_rule({
	name = "KCalc",
	match = {
		class = "(org.kde.kcalc)",
	},
	float = true,
	opaque = true,
	size = "235 333",
})

-- Plasma Open File dialog
hl.window_rule({
	name = "IMPL",
	match = {
		class = "(org.freedesktop.impl.portal.desktop.kde)",
	},
	float = true,
	center = true,
})

-- File pickers center floating
hl.window_rule({
	name = "FilePicker",
	match = {
		title = "^(Open File|Open|Open Source|Save|Import|Choose|Rename|Pick Files), class:^(.*)$",
	},
	center = true,
	float = true,
})

-- Float class
hl.window_rule({
	name = "Float",
	match = {
		class = "^(floating)$",
	},
	float = true,
})

-- Ignore maximize requests from apps
hl.window_rule({
	name = "Maximise",
	match = {
		class = "(.*)",
	},
	suppress_event = "maximize",
})

-- Fix some dragging issues with Wayland
hl.window_rule({
	name = "Unfocus",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Thunderbird
hl.window_rule({
	name = "Thunderbird",
	match = {
		class = "^(org.mozilla.Thunderbird)$",
	},
	workspace = "4",
})

hl.window_rule({
	name = "Thunderbird Float",
	match = {
		class = "^(org.mozilla.Thunderbird)$",
		title = "(Inbox.*|Msgcompose.*|Send.*|Write.*|Reminders.*|status)",
	},
	workspace = "4",
	float = true,
})

-- KDE Plasma workaround for screen sharing
hl.window_rule({
	name = "xwayland-video-bridge-fixes",
	match = {
		class = "xwaylandvideobridge",
	},
	no_initial_focus = true,
	no_focus = true,
	no_anim = true,
	no_blur = true,
	max_size = "1 1",
	opacity = 0.0,
})

hl.window_rule({
	name = "KDE Dialog",
	match = {
		class = "org.kde.kdialog",
	},
	center = true,
	float = true,
})

hl.window_rule({
	name = "TUI apps in foot",
	match = {
		class = "(nmtui|blueman|bluetui|battop|wiremix)",
	},
	center = true,
	float = true,
})

-- Waybar
hl.layer_rule({
	name = "waybar",
	match = {
		namespace = "waybar",
	},
	no_anim = true,
	blur = true,
	no_screen_share = true,
})

-- SwayNC / Notifications
hl.layer_rule({
	name = "swaync",
	match = {
		namespace = "(swaync-control-center|notifications)",
	},
	animation = "slide",
	blur = true,
	no_screen_share = true,
})

hl.layer_rule({
	name = "swaynotifications",
	match = {
		namespace = "(swaync-notification-window)",
	},
	animation = "slide",
	blur = true,
	no_screen_share = true,
})

-- Wlogout
hl.layer_rule({
	name = "wlogout",
	match = {
		namespace = "logout_dialog",
	},
	animation = "fade",
	blur = true,
	no_screen_share = true,
})

-- Launchers
hl.layer_rule({
	name = "rofi",
	match = {
		namespace = "(rofi|walker)",
	},
	animation = "popin 90%",
	blur = true,
	no_screen_share = true,
})
