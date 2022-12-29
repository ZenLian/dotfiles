local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local factory = function(args)
  -- args = {
  -- min = 0,
  -- max = 100,
  -- init_cmd = ,
  -- init_cmd_callback = ,
  -- on_value_change = function (value)
  -- ...
  -- end,
  -- },
  local slider = wibox.widget {
    -- bar_shape = gears.shape.default_frr,
    bar_shape = gears.shape.rounded_bar,
    bar_height = dpi(5),
    bar_color = beautiful.fg_normal .. "33",
    bar_margins = { bottom = dpi(18), top = dpi(18) },
    bar_active_color = beautiful.palette.surface0,
    handle_color = beautiful.palette.surface0,
    handle_shape = gears.shape.circle,
    handle_width = dpi(14),
    handle_border_color = beautiful.palette.blue,
    handle_border_width = dpi(2),
    forced_width = dpi(260),
    shape = gears.shape.rounded_bar,
    minimum = args.min,
    maximum = args.max,
    value = 0,
    widget = wibox.widget.slider,
  }

  return slider
end

return factory
