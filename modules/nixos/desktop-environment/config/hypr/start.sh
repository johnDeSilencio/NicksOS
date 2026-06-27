#!/usr/bin/env bash

# Start wallpaper engine
hyprpaper &

# Start idle detector
hypridle &

# Network manager applet
nm-applet --indicator &

# Bluetooth manager applet
blueman-applet &

mako
