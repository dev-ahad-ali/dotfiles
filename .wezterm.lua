local wezterm = require("wezterm")
-- local mux = wezterm.mux

-- wezterm.on("gui-startup", function()
--  local tab, pane, window = mux.spawn_window{}
--  window:gui_window():maximize()
-- end)

return {
	default_prog = { "/home/dev-ahad-ali/.cargo/bin/zellij" },
	window_close_confirmation = "NeverPrompt",
	font = wezterm.font("JetBrains Mono Nerd Font"),
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	font_size = 14.0,

	-- Start in fullscreen mode
	-- initial_cols = 50, -- Default width
	-- initial_rows = 50,  -- Default height
	-- window_decorations = "RESIZE", -- Remove title bar
	enable_tab_bar = true, -- Keep tab bar enabled
	hide_tab_bar_if_only_one_tab = true, -- Hide tab bar if only one tab

	-- window padding
	window_padding = {
		left = 10,
		right = 5,
		top = 5,
		bottom = 0,
	},

	-- Background settings
	window_background_opacity = 0.9, -- Set opacity (0.0 = fully transparent, 1.0 = opaque)
	macos_window_background_blur = 30, -- Blur effect (macOS only)
	background = {
		{
			source = { Color = "#282828" }, -- Base background color (Gruvbox style)
			width = "100%",
			height = "100%",
			opacity = 0.90, -- Opacity applied to background
		},
	},

	-- Color scheme
	color_scheme = "Tokyo Night", -- Gruvbox dark color scheme

	-- Keybindings
	keys = {
		-- Toggle fullscreen with F11
		{ key = "F11", action = wezterm.action.ToggleFullScreen },
	},
}
