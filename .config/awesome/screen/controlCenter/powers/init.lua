local wibox = require("wibox")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local utils = require("utils")
local p = require("theme.palette")

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
  fg = p.text,
  bg = p.surface0,
  shape = gears.shape.rounded_bar,
}

return wibox.widget {
  nil,
  nil,
  power_button,
  layout = wibox.layout.align.horizontal,
}
