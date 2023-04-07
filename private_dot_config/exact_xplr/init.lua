-- vim:ft=lua

version = "0.21.0"

local xplr = xplr
local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path .. ";" .. xpm_path .. "/?.lua;" .. xpm_path .. "/?/init.lua"

os.execute(string.format("[ -e '%s' ] || git clone '%s' '%s'", xpm_path, xpm_url, xpm_path))

xplr.config.modes.builtin.default.key_bindings.on_key.x = {
	help = "xpm",
	messages = {
		"PopMode",
		{ SwitchModeCustom = "xpm" },
	},
}

xplr.config.general.enable_mouse = true
xplr.config.general.show_hidden = true

xplr.config.modes.builtin.default.key_bindings.on_key["e"] = {
	help = "open in editor",
	messages = {
		{
			BashExec0 = [===[
              ${EDITOR:-vi} "${XPLR_FOCUS_PATH:?}"
            ]===],
		},
		"PopMode",
	},
}

require("xpm").setup({
	plugins = {
		-- Let xpm manage itself
		"dtomvan/xpm.xplr",
		"Junker/nuke.xplr",
		"prncss-xyz/icons.xplr",
		{ name = "sayanarijit/wl-clipboard.xplr" },
		{
			"dtomvan/extra-icons.xplr",
			after = function()
				xplr.config.general.table.row.cols[2] = { format = "custom.icons_dtomvan_col_1" }
			end,
		},
		{
			name = "sayanarijit/fzf.xplr",
			setup = function()
				require("fzf").setup({
					recursive = true,
					enter_dir = true,
				})
			end,
		},
	},
})
