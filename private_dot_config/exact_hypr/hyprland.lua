local mainMod = "SUPER"

local terminal = "foot"
local filemanager = "dolphin"
local fm = 'foot -e {{ (joinPath .chezmoi.homeDir ".local/bin/yazi") | quote }}'
local browser = "librewolf"
local mail = "thunderbird"
local editor = "nvim"

local clipboard = "walker --provider clipboard"
local colourpicker = "hyprpicker --autocopy --format=hex --quiet --lowercase-hex"

local wallpaper = "hyprpaper"

local idle = "hypridle"

local notifications = "swaync"
local notifications_toggle = "swaync-client --toggle-panel"

local spotlight = "walker"
local screenlock = "playerctl --all-players pause; hyprlock"

local suspend = "systemctl suspend"

local sysbar = "waybar"

local current_keymap = "$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | first(.active_keymap)')"

local volumeup = '{{ (print (joinPath .chezmoi.homeDir ".config/wayland/scripts/audio") " " "up") }}'
local volumedown = '{{ print (joinPath .chezmoi.homeDir ".config/wayland/scripts/audio") " " "down" }}'
local volumemute = '{{ print (joinPath .chezmoi.homeDir ".config/wayland/scripts/audio") " " "toggle" }}'

local micmute = '{{ print (joinPath .chezmoi.homeDir ".config/wayland/scripts/audio") " " "mictoggle" }}'

local backlightup = 'brightnessctl s +5%; notify-send --urgency=low --icon=monitor "$(brightnessctl g)"'
local backlightdown = 'brightnessctl s 5%-; notify-send --urgency=low --icon=monitor "$(brightnessctl g)"'

local dock_toggle = '{{ joinPath .chezmoi.homeDir ".config/wayland/scripts/dock_toggle" }}'

local logout = "hyprctl dispatch exit"

if is_file_exists(HOME .. "/.config/hypr/theme.lua") then
	require("theme")
end

if is_file_exists(HOME .. "/.config/hypr/modules/env.lua") then
	require("modules.env")
end

if is_file_exists(HOME .. "/.config/hypr/modules/autostart.lua") then
	require("modules.autostart")
end

if is_file_exists(HOME .. "/.config/hypr/modules/input.lua") then
	require("modules.input")
end
if is_file_exists(HOME .. "/.config/hypr/modules/monitors.lua") then
	require("modules.monitors")
end

if is_file_exists(HOME .. "/.config/hypr/modules/windowrules.lua") then
	require("modules.windowrules")
end
if is_file_exists(HOME .. "/.config/hypr/modules/workspaces.lua") then
	require("modules.workspaces")
end

if is_file_exists(HOME .. "/.config/hypr/modules/ui.lua") then
	require("modules.ui")
end

if is_file_exists(HOME .. "/.config/hypr/modules/permissions.lua") then
	require("modules.permissions")
end

if is_file_exists(HOME .. "/.config/hypr/bindings/general.lua") then
	require("bindings.general")
end
if is_file_exists(HOME .. "/.config/hypr/bindings/applications.lua") then
	require("bindings.applications")
end
if is_file_exists(HOME .. "/.config/hypr/bindings/tiles.lua") then
	require("bindings.tiles")
end
if is_file_exists(HOME .. "/.config/hypr/bindings/macos.lua") then
	require("bindings.macos")
end
if is_file_exists(HOME .. "/.config/hypr/bindings/media.lua") then
	require("bindings.media")
end
if is_file_exists(HOME .. "/.config/hypr/bindings/hardware.lua") then
	require("bindings.hardware")
end
