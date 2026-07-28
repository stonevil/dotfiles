-- https://wiki.hypr.land/Configuring/Keywords/#executing

hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user import-environment $(env | cut -d'=' -f 1) >/dev/null 2>&1 &")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP >/dev/null 2>&1 &")
	hl.exec_cmd("dbus-update-activation-environment --systemd --all >/dev/null 2>&1 &")
	hl.exec_cmd("pam_kwallet_init")
	hl.exec_cmd("udiskie -t >/dev/null 2>&1 &")
	hl.exec_cmd("systemctl --user start hyprpolkitagent >/dev/null 2>&1 &")
	hl.exec_cmd("$idle >/dev/null 2>&1 &")
	hl.exec_cmd("$wallpaper >/dev/null 2>&1 &")
	hl.exec_cmd("$notifications >/dev/null 2>&1 &")
	hl.exec_cmd("elephant >/dev/null 2>&1 &")
	hl.exec_cmd("walker --gapplication-service >/dev/null 2>&1 &")
	hl.exec_cmd("playerctld >/dev/null 2>&1 &")
	hl.exec_cmd("sleep 10s; rog-control-center >/dev/null 2>&1 &")
	hl.exec_cmd("sleep 10s; $sysbar >/dev/null 2>&1 &")
	hl.exec_cmd(
		'sleep 10s; {{ print (joinPath .chezmoi.homeDir ".config/wayland/scripts/audio") " " "micmute" }} >/dev/null 2>&1 &'
	)
	hl.exec_cmd("hyprctl dispatch workspace 1 >/dev/null 2>&1 &")
end)
