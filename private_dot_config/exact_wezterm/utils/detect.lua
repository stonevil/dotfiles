local wezterm = require("wezterm")

local detect = {}

function detect.wayland()
	-- Wayland support
	local wayland = os.getenv("XDG_SESSION_TYPE")
	if wayland == "wayland" then
		return true
	end
	return false
end

function detect.appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function detect.colours(theme)
	return {
		colour12 = theme.colour12,
		window_frame_colors = {
			active_titlebar_bg = theme.background,
			inactive_titlebar_bg = wezterm.color.parse(theme.background):darken(0.8),
		},
		tab_bar_colors = {
			inactive_tab_edge = wezterm.color.parse(theme.background):darken(0.8),
			active_tab = {
				bg_color = theme.brights[3],
				fg_color = theme.background,
			},
			inactive_tab = {
				bg_color = theme.background,
				fg_color = theme.foreground,
			},
			inactive_tab_hover = {
				bg_color = wezterm.color.parse(theme.background):lighten(0.1),
				fg_color = wezterm.color.parse(theme.foreground):lighten(0.2),
			},
			new_tab = {
				bg_color = theme.background,
				fg_color = theme.foreground,
			},
			new_tab_hover = {
				bg_color = theme.brights[3],
				fg_color = theme.background,
			},
		},
	}
end

function detect.vi(pane)
	return pane:get_foreground_process_name():find("n?vim") ~= nil
end

function detect.basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

function detect.isempty(s)
	return s == nil or s == ""
end

function detect.cwd(pane)
	local cwd = ""
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		cwd = cwd_uri.file_path
	end
	return cwd
end

function detect.hostname(pane)
	local hostname = ""
	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		hostname = cwd_uri.host or wezterm.hostname()
	end
	return hostname
end

function detect.os()
	-- Return two strings describing the OS name and OS architecture.
	-- For Windows, the OS identification is based on environment variables, on unix, a call to uname is used.
	--
	-- OS possible values: Windows, Linux, Mac, BSD, Solaris
	-- Arch possible values: x86, x86864, powerpc, arm, mips
	--
	-- On Windows, detection based on environment variable is limited to what Windows is willing to tell through environement variables. In particular 64bits is not always indicated so do not rely hardly on this value.

	local raw_os_name, raw_arch_name = "", ""

	-- LuaJIT shortcut
	if jit and jit.os and jit.arch then
		raw_os_name = jit.os
		raw_arch_name = jit.arch
	-- print( ("Debug jit name: %q %q"):format( raw_os_name, raw_arch_name ) )
	else
		if package.config:sub(1, 1) == "\\" then
			-- Windows
			local env_OS = os.getenv("OS")
			local env_ARCH = os.getenv("PROCESSOR_ARCHITECTURE")
			-- print( ("Debug: %q %q"):format( env_OS, env_ARCH ) )
			if env_OS and env_ARCH then
				raw_os_name, raw_arch_name = env_OS, env_ARCH
			end
		else
			-- other platform, assume uname support and popen support
			raw_os_name = io.popen("uname -s", "r"):read("*l")
			raw_arch_name = io.popen("uname -m", "r"):read("*l")
		end
	end

	raw_os_name = (raw_os_name):lower()
	raw_arch_name = (raw_arch_name):lower()

	-- print( ("Debug: %q %q"):format( raw_os_name, raw_arch_name) )

	local os_patterns = {
		["windows"] = "Windows",
		["linux"] = "Linux",
		["osx"] = "Mac",
		["mac"] = "Mac",
		["darwin"] = "Mac",
		["^mingw"] = "Windows",
		["^cygwin"] = "Windows",
		["bsd$"] = "BSD",
		["sunos"] = "Solaris",
	}

	local arch_patterns = {
		["^x86$"] = "x86",
		["i[%d]86"] = "x86",
		["amd64"] = "x86_64",
		["x86_64"] = "x86_64",
		["x64"] = "x86_64",
		["power macintosh"] = "powerpc",
		["^arm"] = "arm",
		["^mips"] = "mips",
		["i86pc"] = "x86",
	}

	local os_name, arch_name = "unknown", "unknown"

	for pattern, name in pairs(os_patterns) do
		if raw_os_name:match(pattern) then
			os_name = name
			break
		end
	end
	for pattern, name in pairs(arch_patterns) do
		if raw_arch_name:match(pattern) then
			arch_name = name
			break
		end
	end
	return os_name, arch_name
end

return detect
