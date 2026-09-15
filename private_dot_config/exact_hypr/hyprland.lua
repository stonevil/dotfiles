homeDirPath = os.getenv("HOME")

mainMod = "SUPER"

terminal = "foot"
fileManager = "dolphin"
fm = "foot -e" .. " " .. "yazi"
browser = "librewolf"
mail = "thunderbird"
editor = "neovide"

clipboardToggle = "noctalia msg panel-toggle clipboard"
colourPickerToggle = "hyprpicker --autocopy --format=hex --quiet --lowercase-hex"

screenshotOutput = "noctalia msg screenshot-fullscreen pick"
screenshotRegion = "noctalia msg screenshot-region"

notificationsToggle = "noctalia msg panel-toggle control-center"

spotLightToggle = "noctalia msg panel-toggle launcher"
screenLock = "playerctl --all-players pause; noctalia msg session lock"

sysBar = "noctalia"

currentKeymap = "$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | first(.active_keymap)')"

volumeUp = "noctalia msg volume-up"
volumeDown = "noctalia msg volume-down"
volumeMute = "noctalia msg volume-mute"

micMute = homeDirPath .. "/.config/wayland/scripts/audio mictoggle"

backLightUp = "noctalia msg brightness-up"
backLightDown = "noctalia msg brightness-down"

dockToggle = "noctalia msg bar-toggle"

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
