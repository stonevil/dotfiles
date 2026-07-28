hl.bind(
	"CTRL + SPACE",
	hl.dsp.exec_cmd("notify-send --urgency=low --icon=language-chooser $current_keymap"),
	{ locked = true }
)

hl.bind("SUPER + SHIFT + 3", hl.dsp.exec_cmd("hyprshot -m output"), { description = "Screenshot window" })
hl.bind("SUPER + SHIFT + 4", hl.dsp.exec_cmd("hyprshot -m window"), { description = "Screenshot area" })
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m window"), { description = "Screenshot window" })
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"), { description = "Screenshot area" })

hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("$spotlight"), { description = "Spotlight" })

hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd("$notifications"), { description = "Notification Center" })

hl.bind("SUPER + CTRL + L", hl.dsp.exec_cmd("$screenlock"), { description = "Lock the screen" })

hl.bind("SUPER + CTRL + SHIFT + Q", hl.dsp.exec_cmd("$suspend"), { description = "Suspend" })

hl.bind("SUPER + CTRL + ALT + Q", hl.dsp.exec_cmd("$logout"), { description = "Exit Hyprland" })
