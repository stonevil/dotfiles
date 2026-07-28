-- Screencopy
hl.permission({ binary = "/usr/(bin/hyprshot|bin/hyprlock|sbin/grim)", type = "screencopy", allow = "allow" })
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", allow = "allow" })

-- Keyboards
-- hl.permission({ binary = "(video-bus|power-button|sleep-button|asus-wmi-hotkeys)", type = "keyboard", allow = "allow" })
-- hl.permission({ binary = "^(ite-tech.-inc.-ite-device)$", type = "keyboard", allow = "allow" })
-- hl.permission({ binary = "compx-xlite-mini-wireless-keyboard", type = "keyboard", allow = "allow" })
-- hl.permission({ binary = "logitech-mx-ergo", type = "keyboard", allow = "allow" })
-- hl.permission({ binary = "^(nuphy-nuphy-air75-he)$", type = "keyboard", allow = "allow" })
-- hl.permission({ binary = ".*", type = "keyboard", allow = "deny" })

-- Hyprland Plugins Manager
hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", allow = "allow" })
