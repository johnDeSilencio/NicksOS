-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can split this configuration into multiple files
-- Create your files separately and then link them to this file like this:
-- require("myColors")

----------------
--- MONITORS ---
----------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "auto",
})

hl.monitor({
	output = "Sony SONY TV 0x01010101",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

hl.monitor({
	output = "WDT UW32SC1W 6980Y24405405",
	mode = "1366x768",
	position = "2560x0",
	scale = 0.5,
})

hl.monitor({
	output = "eDP-1",
	mode = "2560x1600",
	position = "0x0",
	scale = 1,
})

-------------------
--- MY PROGRAMS ---
-------------------

-- Set programs that you use
local terminal = "wezterm"
local fileManager = "dolphin"

-----------------
--- AUTOSTART ---
-----------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

hl.on("hyprland.start", function()
	hl.exec_cmd("bash ~/.config/hypr/start.sh")
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--    ecosystem = {
--        enforce_permissions = true,
--    }
-- })

---------------------
--- LOOK AND FEEL ---
---------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 30,
		gaps_out = 30,

		border_size = 0,

		col = {
			active_border = { colors = { "rgba(cc922dee)", "rgba(b18840ee)" }, angle = 45 },
			inactive_border = "rgba(b3b3b3aa)",
		},

		-- Set to true enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 15,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 60,
			render_power = 2,
			offset = { 15, 15 },
			color = "rgba(1a1a1abb)",
			scale = "1.1",
		},

		-- https://wiki.hypr.land/Configuring/Variables/#blur
		blur = {
			enabled = true,
			new_optimizations = true,
			size = 8,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

local speed = 10

hl.animation({ leaf = "windows", enabled = true, speed = speed, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = speed, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = speed, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = speed, bezier = "wind", style = "slide" })
hl.animation({ leaf = "border", enabled = true, speed = speed, bezier = "linear" })
hl.animation({ leaf = "borderangle", enabled = true, speed = speed, bezier = "linear", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = speed, bezier = "linear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = speed, bezier = "wind" })

-- See https://wiki.hypr.land/Configuring/Master-Layout/ for more
hl.config({
	master = {
		new_status = "master",
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = true, -- If true disables the random hyprland logo / anime girl background. :(
		focus_on_activate = true, -- If an app in a different workspace requests focus, move to that workspace
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "caps:swapescape",
		kb_rules = "",

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
			clickfinger_behavior = 1,
			disable_while_typing = false,
		},
	},
})

-- hl.gesture({
--   workspace_swipe_touch = false,
-- })

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
	name = "epic-mouse-v1",
	sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- # Move windows between monitors
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Bind rofi launcher
hl.bind(mainMod .. "+ SPACE", hl.dsp.exec_cmd('rofi -show drun -display-drun "" -show-icons'))

-- Bind volume function keys
hl.bind("F1", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("F2", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("F3", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })

-- Bind audio / media funtion keys
hl.bind("F4", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("F5", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("F6", hl.dsp.exec_cmd("playerctl next"))

-- Bind brightness function keys
hl.bind("F7", hl.dsp.exec_cmd("brightnessctl set 10%-"), { repeating = true })
hl.bind("F8", hl.dsp.exec_cmd("brightnessctl set +10%"), { repeating = true })

-- Bind fullscreen function key toggle
-- TODO: This currently does nothing
hl.bind("Super_L", hl.dsp.exec_cmd("fullscreen"))

-- Bind airplane mode key
hl.bind("F10", hl.dsp.exec_cmd("rfkill toggle 0 && rfkill toggle 1"))

-- Bind print screen key for printing the current window and copying to clipboard
hl.bind(
	"F11",
	hl.dsp.exec_cmd(
		'pidof -x "$(dirname $(readlink -f $(which hyprshot)))/.hyprshot-wrapped" &>/dev/null || hyprshot -m window --clipboard-only'
	)
)
-- Bind print screen key for printing a selected region and copying to clipboard
hl.bind(
	"SHIFT + F11",
	hl.dsp.exec_cmd(
		'pidof -x "$(dirname $(readlink -f $(which hyprshot)))/.hyprshot-wrapped" &>/dev/null || hyprshot -m region --clipboard-only'
	)
)

-- Bind print screen key for printing the current screen and saving to disk.
hl.bind(
	"SUPER + F11",
	hl.dsp.exec_cmd(
		'pidof -x "$(dirname $(readlink -f $(which hyprshot)))/.hyprshot-wrapped" &>/dev/null || hyprshot -m output -o /home/nicholas/Pictures/Screenshots/'
	)
)
-- Bind print screen key for printing the current window and saving to disk
hl.bind(
	"SUPER + SHIFT + F11",
	hl.dsp.exec_cmd(
		'pidof -x "$(dirname $(readlink -f $(which hyprshot)))/.hyprshot-wrapped" &>/dev/null || hyprshot -m window -o /home/nicholas/Pictures/Screenshots/'
	)
)

-- Bind framework logo key. Will only run if wlogout is not already running.
hl.bind("F12", hl.dsp.exec_cmd("pidof $(which wlogout) &>/dev/null || wlogout --protocol layer-shell"))

-- Bind calculator key
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-qt"))

-- Bind keyboard shortcut to open query.rs for Rust-related searches
hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd('xdg-open "https://query.rs"'))

-- Toggle Waybar
hl.bind(
	"SUPER + SHIFT + T",
	hl.dsp.exec_cmd("pidof $(which waybar) &>/dev/null && kill $(pidof $(which waybar)) &>/dev/null || waybar")
)

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Polyfill: hide xwaylandvideobridge window which is used to enable screen sharing on Wayland

hl.window_rule({
	name = "polyfill-hide-xwaylandvideobridge",
	match = {
		class = "^(xwaylandvideobridge)$",
	},
	opacity = "0.0 override",
	no_anim = true,
	no_initial_focus = true,
	max_size = { 1, 1 },
	no_blur = true,
})

-- Handle inactivity timeouts
hl.dsp.exec_cmd("hypridle")

-- Handle laptop lid closing (inverted logic). Only turns off the built-in display
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms off eDP-1"), { locked = true })

-- # Handle laptop lid opening (inverted logic). Turns on all displays
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms on"), { locked = true })
