local wezterm = require("wezterm")

-- show battery infos
wezterm.on("update-right-status", function(window, _)
	local date = wezterm.strftime("%a %b %-d %H:%M ")

	local bat = ""
	for _, b in ipairs(wezterm.battery_info()) do
		bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
	end

	window:set_right_status(wezterm.format({
		{ Text = bat .. "   " .. wezterm.nerdfonts.mdi_clock .. "   " .. date },
	}))
end)

return {
	window_background_opacity = 1.0,
	line_height = 1,
	font_size = 16,
	font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
	color_scheme = "Argonaut",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	text_background_opacity = 1,
	keys = {
		{
			key = "d",
			mods = "CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		-- Make Option-Right equivalent to Alt-f; forward-word
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	},
	-- disable_default_key_bindings = true,
}
