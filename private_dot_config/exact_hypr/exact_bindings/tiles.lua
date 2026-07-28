-- Close tile
hl.bind("SUPER + CTRL + W", hl.dsp.window.close(), { description = "Close tile" })
hl.bind("SUPER + CTRL + Q", hl.dsp.window.close(), { description = "Close tile" })

-- Control tiling
hl.bind(
	"SUPER + CTRL + T",
	hl.dsp.window.float({ action = "toggle" }),
	{ description = "Toggle window floating/tiling" }
)
hl.bind(
	"SUPER + CTRL + F",
	hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
	{ description = "Full width" }
)

-- Move focus with SUPER + arrow keys
hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "left" }), { description = "Move window focus left" })
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "right" }), { description = "Move window focus right" })
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "up" }), { description = "Move window focus up" })
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "down" }), { description = "Move window focus down" })

-- Swap window with SUPER + SHIFT + arrow keys
hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.swap({ direction = "l" }), { description = "Swap window to the left" })
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.swap({ direction = "r" }), { description = "Swap window to the right" })
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.swap({ direction = "u" }), { description = "Swap window to the up" })
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.focus({ direction = "down" }), { description = "Swap window to the down" })

-- Switch workspaces with SUPER + ALT + [1-9]
hl.bind("SUPER + ALT + code:10", hl.dsp.focus({ workspace = 1 }), { description = "Switch to workspace 1" })
hl.bind("SUPER + ALT + code:11", hl.dsp.focus({ workspace = 2 }), { description = "Switch to workspace 2" })
hl.bind("SUPER + ALT + code:12", hl.dsp.focus({ workspace = 3 }), { description = "Switch to workspace 3" })
hl.bind("SUPER + ALT + code:13", hl.dsp.focus({ workspace = 4 }), { description = "Switch to workspace 4" })
hl.bind("SUPER + ALT + code:14", hl.dsp.focus({ workspace = 5 }), { description = "Switch to workspace 5" })
hl.bind("SUPER + ALT + code:15", hl.dsp.focus({ workspace = 6 }), { description = "Switch to workspace 6" })
hl.bind("SUPER + ALT + code:16", hl.dsp.focus({ workspace = 7 }), { description = "Switch to workspace 7" })
hl.bind("SUPER + ALT + code:17", hl.dsp.focus({ workspace = 8 }), { description = "Switch to workspace 8" })
hl.bind("SUPER + ALT + code:18", hl.dsp.focus({ workspace = 9 }), { description = "Switch to workspace 9" })
hl.bind("SUPER + ALT + code:19", hl.dsp.focus({ workspace = 10 }), { description = "Switch to workspace 10" })

-- Switch to previous workspace
hl.bind(
	"SUPER + ALT + slash",
	hl.dsp.focus({ workspace = "previous" }),
	{ description = "Switch to previous workspace" }
)

-- Move active window to a workspace with SUPER + ALT + SHIFT + [1-9]
hl.bind(
	"SUPER + ALT + SHIFT + code:10",
	hl.dsp.window.move({ workspace = 1 }),
	{ description = "Move window to workspace 1" }
)
hl.bind(
	"SUPER + ALT + SHIFT + code:11",
	hl.dsp.window.move({ workspace = 2 }),
	{ description = "Move window to workspace 2" }
)
hl.bind(
	"SUPER + ALT + SHIFT + code:12",
	hl.dsp.window.move({ workspace = 3 }),
	{ description = "Move window to workspace 3" }
)
hl.bind(
	"SUPER + ALT + SHIFT + code:13",
	hl.dsp.window.move({ workspace = 4 }),
	{ description = "Move window to workspace 4" }
)
hl.bind(
	"SUPER + ALT + SHIFT + code:14",
	hl.dsp.window.move({ workspace = 5 }),
	{ description = "Move window to workspace 5" }
)
hl.bind(
	"SUPER + ALT + SHIFT + code:15",
	hl.dsp.window.move({ workspace = 6 }),
	{ description = "Move window to workspace 6" }
)
hl.bind(
	"SUPER + ALT + SHIFT + code:16",
	hl.dsp.window.move({ workspace = 7 }),
	{ description = "Move window to workspace 7" }
)
hl.bind(
	"SUPER + ALT + SHIFT + code:17",
	hl.dsp.window.move({ workspace = 8 }),
	{ description = "Move window to workspace 8" }
)
hl.bind(
	"SUPER + ALT + SHIFT + code:18",
	hl.dsp.window.move({ workspace = 9 }),
	{ description = "Move window to workspace 9" }
)
hl.bind(
	"SUPER + ALT + SHIFT + code:19",
	hl.dsp.window.move({ workspace = 10 }),
	{ description = "Move window to workspace 10" }
)

-- Move workspaces to other monitors with SUPER + ALT + SHIFT + arrow keys
hl.bind("SUPER + ALT + SHIFT + LEFT", function()
	local w = hl.get_active_workspace()
	if not w then
		return
	end
	hl.dispatch(hl.dsp.workspace.move({ workspace = w.id, monitor = "l" }))
end, { description = "Move workspace to left monitor" })
hl.bind("SUPER + ALT + SHIFT + RIGHT", function()
	local w = hl.get_active_workspace()
	if not w then
		return
	end
	hl.dispatch(hl.dsp.workspace.move({ workspace = w.id, monitor = "r" }))
end, { description = "Move workspace to right monitor" })

-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { description = "Move window" })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { description = "Resize window" })

-- Resize submap
hl.bind("SUPER + CTRL + R", hl.dsp.submap("resize"))
-- Start a submap called "resize".
hl.define_submap("resize", function()
	-- Set repeatable binds for resizing the active window.
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
	-- Reset the submap, which will return to the global submap
end)

-- Resize with gestures
hl.gesture({
	fingers = 2,
	direction = "pinch",
	action = "mod: SUPER",
	-- TODO: manual review — extra gesture field "resize"
})
hl.gesture({
	fingers = 2,
	direction = "swipe",
	action = "mod: SUPER",
	-- TODO: manual review — extra gesture field "move"
})
