hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("$backlightup"),
	{ locked = true, repeating = true, description = "Brightness increase" }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("$backlightdown"),
	{ locked = true, repeating = true, description = "Brightness decrease" }
)

hl.bind("XF86Launch1", hl.dsp.exec_cmd("rog-control-center"), { description = "ROG Control Center" })

hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })
