#!/usr/bin/env bash

# Start wallpaper engine
hyprpaper &

nm-applet --indicator &

# The app bar
waybar &

mako
