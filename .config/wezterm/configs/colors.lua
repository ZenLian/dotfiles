local wezterm = require("wezterm")

local colors = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
colors.background = "#11111e"
colors.quick_select_label_bg = { Color = "#a6e3a1" }
colors.quick_select_label_fg = { Color = "#1e1e2e" }

return { colors = colors }
