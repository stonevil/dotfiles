homeDirPath = os.getenv("HOME")

mainMod = "SUPER"

terminal = "foot"
fileManager = "dolphin"
fm = "foot -e" .. " " .. "yazi"
browser = "librewolf"
mail = "thunderbird"
editor = "nvim"

clipboard = "walker --provider clipboard"
colourPicker = "hyprpicker --autocopy --format=hex --quiet --lowercase-hex"

screenshotOutput = "hyprshot -m output"
screenshotWindow = "hyprshot -m window"
screenshotRegion = "hyprshot -m region"

screenshotOutput2Clipboard = "hyprshot -m output --clipboard-only"
screenshotWindow2Clipboard = "hyprshot -m window --clipboard-only"
screenshotRegion2Clipboard = "hyprshot -m region --clipboard-only"

wallpaper = "hyprpaper"

idle = "hypridle"

notifications = "swaync"
notificationsToggle = "swaync-client --toggle-panel"

spotLight = "walker"
screenLock = "playerctl --all-players pause; hyprlock"

suspend = "systemctl suspend"

sysBar = "waybar"

currentKeymap = "$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | first(.active_keymap)')"

volumeUp = homeDirPath .. "/.config/wayland/scripts/audio up"
volumeDown = homeDirPath .. "/.config/wayland/scripts/audio down"
volumeMute = homeDirPath .. "/.config/wayland/scripts/audio toggle"

micMute = homeDirPath .. "/.config/wayland/scripts/audio mictoggle"

backLightUp = 'brightnessctl s +5%; notify-send --urgency=low --icon=monitor "$(brightnessctl g)"'
backLightDown = 'brightnessctl s 5%-; notify-send --urgency=low --icon=monitor "$(brightnessctl g)"'

dockToggle = homeDirPath .. "/.config/wayland/scripts/dock_toggle"

logOut = "hyprshutdown"

require("theme")
require("modules.env")
require("modules.autostart")
require("modules.input")
require("modules.monitors")
require("modules.windowrules")
require("modules.workspaces")
require("modules.ui")
require("modules.permissions")
require("bindings.general")
require("bindings.applications")
require("bindings.tiles")
require("bindings.macos")
require("bindings.media")
require("bindings.hardware")
