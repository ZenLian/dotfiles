local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local utils = require("zl.utils")
local theme = require("zl.theme")

local power_button = wibox.widget {
  {
    {
      widget = wibox.widget.textbox,
      font = utils.icon_font(18),
      text = "󰐥",
    },
    widget = wibox.container.margin,
    margins = dpi(10),
  },
  widget = wibox.container.background,
  fg = theme.color.on_surface,
  bg = theme.color.surface,
  shape = gears.shape.rounded_bar,
}

return wibox.widget {
  nil,
  nil,
  power_button,
  layout = wibox.layout.align.horizontal,
}
