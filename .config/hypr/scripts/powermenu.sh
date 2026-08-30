#!/usr/bin/env bash

# Options
lock="🔒 Lock"
logout="󰍃 Logout"
suspend="󰤄 Suspend"
reboot="󰜉 Reboot"
shutdown=" Shutdown"

# Variable passed to wofi
options="$lock\n$logout\n$suspend\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | wofi --dmenu --prompt "Power Menu" --width 250 --height 240 --style ~/.config/wofi/style.css)"

case $chosen in
    $lock)
        hyprlock || swaylock ;;
    $logout)
        hyprctl dispatch exit ;;
    $suspend)
        systemctl suspend ;;
    $reboot)
        systemctl reboot ;;
    $shutdown)
        systemctl poweroff ;;
esac
