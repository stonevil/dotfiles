hl.bind(
	"CTRL + SPACE",
	hl.dsp.exec_cmd("notify-send --urgency=low --icon=language-chooser $current_keymap"),
	{ locked = true }
)

hl.bind("SUPER + SHIFT + 3", hl.dsp.exec_cmd(screenshotOutput), { description = "Screenshot Screen" })
hl.bind("SUPER + SHIFT + 4", hl.dsp.exec_cmd(screenshotRegion), { description = "Screenshot Area" })
hl.bind("SUPER + SHIFT + 5", hl.dsp.exec_cmd(screenshotWindow), { description = "Screenshot Window" })

hl.bind("SUPER + SHIFT + ALT + 3", hl.dsp.exec_cmd(screenshotOutput2Clipboard), { description = "Screenshot Screen" })
hl.bind("SUPER + SHIFT + ALT + 4", hl.dsp.exec_cmd(screenshotRegion2Clipboard), { description = "Screenshot Area" })
hl.bind("SUPER + SHIFT + ALT + 5", hl.dsp.exec_cmd(screenshotWindow2Clipboard), { description = "Screenshot Window" })

hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(spotLight), { description = "Spotlight" })

hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd(notifications), { description = "Notification Center" })

hl.bind("SUPER + CTRL + L", hl.dsp.exec_cmd(screenLock), { description = "Lock the screen" })

hl.bind("SUPER + CTRL + SHIFT + Q", hl.dsp.exec_cmd(suspend), { description = "Suspend" })

hl.bind("SUPER + CTRL + ALT + Q", hl.dsp.exec_cmd(logOut), { description = "Exit Hyprland" })
