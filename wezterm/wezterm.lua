local wezterm = require("wezterm")

return {
	-- Appearance
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = true,
	font_size = 10.0,
	window_frame = {
		font_size = 8.0,
	},

	window_decorations = "NONE",
	color_scheme = "Adventure", -- pick any you like
	font = wezterm.font_with_fallback({
		"JetBrains Mono Nerd Font",
		"Fira Code",
		"monospace",
	}),

	-- Clipboard sync (works with OSC 52)
	enable_wayland = false, -- or true if you're on Wayland and it works
	set_environment_variables = {
		TERM = "wezterm",
	},

	-- Keybindings for splits
	keys = {
		{
			key = "Enter",
			mods = "ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "Enter",
			mods = "CTRL",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
	},

	-- Mouse-friendly copy/paste
	mouse_bindings = {
		-- Ctrl+Click to open links
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
		-- Default left-click to select (works well)
		{
			event = { Down = { streak = 1, button = "Left" } },
			action = wezterm.action.SelectTextAtMouseCursor("Cell"),
		},
	},

	-- Scrollback buffer
	scrollback_lines = 10000,

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
