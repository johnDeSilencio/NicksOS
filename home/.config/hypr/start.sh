#!/usr/bin/env bash

# Start wallpaper engine
hyprpaper &

# Network manager applet
nm-applet --indicator &

# Bluetooth manager applet
blueman-applet &

# The app bar
waybar &

mako
