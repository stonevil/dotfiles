hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("$volumeup"),
	{ locked = true, repeating = true, description = "Volume increase" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("$volumedown"),
	{ locked = true, repeating = true, description = "Volume decrease" }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("$volumemute"),
	{ locked = true, repeating = true, description = "Volume mute" }
)

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("$micmute"), { description = "Microphone mute" })

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Play" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Pause" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { description = "Next" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { description = "Previous" })
