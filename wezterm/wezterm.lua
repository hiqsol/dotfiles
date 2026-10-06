local wezterm = require("wezterm")

local BASE_FONT_SIZE = 13.0

-- Default Increase/DecreaseFontSize multiply by 1.1, giving fractional pixel
-- sizes that render blurry. Step by whole logical pixels instead and snap
-- font_size (points) so the resulting pixel size is an integer.
local function step_font_size(delta)
	return wezterm.action_callback(function(window, _)
		local dpi = window:get_dimensions().dpi
		local overrides = window:get_config_overrides() or {}
		local pt = overrides.font_size or BASE_FONT_SIZE
		local step = dpi / 96 -- one logical pixel in device pixels
		local px = math.floor(pt * dpi / 72 / step + 0.5) + delta
		if px < 6 then
			return
		end
		overrides.font_size = px * step * 72 / dpi
		window:set_config_overrides(overrides)
	end)
end

local function reset_font_size()
	return wezterm.action_callback(function(window, _)
		local overrides = window:get_config_overrides() or {}
		overrides.font_size = nil
		window:set_config_overrides(overrides)
	end)
end

return {
	-- Appearance
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = true,
	font_size = BASE_FONT_SIZE,
	window_frame = {
		font_size = 10.0,
	},

	window_decorations = "NONE",
	color_scheme = "Adventure",
	font = wezterm.font_with_fallback({
		"JetBrains Mono Nerd Font",
		"Noto Color Emoji",
		"Symbols Nerd Font Mono",
	}),

	inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.5,
	},
	colors = {
		split = "#DD4814",
	},

	-- Clipboard sync (works with OSC 52)
	enable_wayland = false, -- or true if you're on Wayland and it works
	set_environment_variables = {
		TERM = "wezterm",
	},

	-- Keybindings for splits
	keys = {
		{ key = "=", mods = "CTRL", action = step_font_size(1) },
		{ key = "+", mods = "CTRL", action = step_font_size(1) },
		{ key = "+", mods = "CTRL|SHIFT", action = step_font_size(1) },
		{ key = "-", mods = "CTRL", action = step_font_size(-1) },
		{ key = "_", mods = "CTRL|SHIFT", action = step_font_size(-1) },
		{ key = "0", mods = "CTRL", action = reset_font_size() },

		{ key = "Enter", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "Enter", mods = "CTRL", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

		{ key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },

		{ key = "1", mods = "ALT", action = wezterm.action.ActivateTab(0) },
		{ key = "2", mods = "ALT", action = wezterm.action.ActivateTab(1) },
		{ key = "3", mods = "ALT", action = wezterm.action.ActivateTab(2) },
		{ key = "4", mods = "ALT", action = wezterm.action.ActivateTab(3) },
		{ key = "5", mods = "ALT", action = wezterm.action.ActivateTab(4) },
		{ key = "6", mods = "ALT", action = wezterm.action.ActivateTab(5) },
		{ key = "7", mods = "ALT", action = wezterm.action.ActivateTab(6) },
		{ key = "8", mods = "ALT", action = wezterm.action.ActivateTab(7) },
		{ key = "9", mods = "ALT", action = wezterm.action.ActivateTab(8) },
	},

	-- Mouse-friendly copy/paste
	mouse_bindings = {
		-- Ctrl+Click to open links
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
		-- Same inside apps with mouse reporting (Claude Code, tmux with mouse on)
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			mouse_reporting = true,
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
		{
			event = { Down = { streak = 1, button = "Left" } },
			mods = "CTRL",
			mouse_reporting = true,
			action = wezterm.action.Nop,
		},
		-- Default left-click to select (works well)
		{
			event = { Down = { streak = 1, button = "Left" } },
			action = wezterm.action.SelectTextAtMouseCursor("Cell"),
		},
		-- Wheel scrolls scrollback in normal screen; in alt screen (less, man)
		-- keep default: wezterm sends Up/Down keys
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "NONE",
			alt_screen = false,
			action = wezterm.action.ScrollByLine(-3),
		},
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "NONE",
			alt_screen = false,
			action = wezterm.action.ScrollByLine(3),
		},
	},

	-- Scrollback buffer
	scrollback_lines = 100000,

	-- Optional launch menu for quickly opening shell or ssh
	launch_menu = {
		{ label = "Bash Shell", args = { "bash", "-l" } },
		{ label = "Zsh Shell", args = { "zsh", "-l" } },
		{ label = "SSH: fractal", args = { "ssh", "fractal" } },
	},

	-- Window tweaks
	window_padding = {
		left = 3,
		right = 3,
		top = 1,
		bottom = 1,
	},
	adjust_window_size_when_changing_font_size = false,
}
