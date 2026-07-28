hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("$terminal"), { description = "Terminal" })
hl.bind("SUPER + CTRL + RETURN", hl.dsp.exec_cmd("$filemanager"), { description = "File manager" })
hl.bind("SUPER + CTRL + ALT + RETURN", hl.dsp.exec_cmd("$fm"), { description = "CLI file manager" })

hl.bind("SUPER + CTRL + B", hl.dsp.exec_cmd("$browser"), { description = "Web browser" })
hl.bind("SUPER + CTRL + M", hl.dsp.exec_cmd("$mail"), { description = "Mail client" })

hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("$clipboard"), { description = "Clipboard history" })

hl.bind("SUPER + CTRL + C", hl.dsp.exec_cmd("$colourpicker"), { description = "Colour picker" })

hl.bind("SUPER + CTRL + D", hl.dsp.exec_cmd("$dock_toggle"), { description = "Toggle Dock and Panel" })

hl.bind("SUPER + CTRL + N", hl.dsp.exec_cmd("$notifications_toggle"), { description = "Toggle NC" })
