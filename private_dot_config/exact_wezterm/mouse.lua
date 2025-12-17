local wezterm = require("wezterm")
local act = wezterm.action
local M = {}

function M.setup(config)
	config.mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "SUPER",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	}
end

return M
