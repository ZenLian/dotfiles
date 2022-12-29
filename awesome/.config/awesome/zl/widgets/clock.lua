local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local lain = require("lain")

local factory = function()
  local clk = wibox.widget.textclock("%H:%M")

  local cal = lain.widget.cal {
    attach_to = { clk },
    notification_preset = {
      font = beautiful.options.font.family .. " 11",
      fg = beautiful.tooltip_fg,
      bg = beautiful.tooltip_bg,
      border_width = 0,
    },
  }

  awesome.connect_signal("zl::cal_show", function(args)
    args = args or {}
    cal.show(args.timeout)
  end)

  return clk
end

return factory
