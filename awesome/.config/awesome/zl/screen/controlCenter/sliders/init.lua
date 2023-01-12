local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local slider = require(... .. ".slider")
local utils = require("zl.utils")
local theme = require("zl.theme")
local service = require("zl.service")

local volume = slider {
  min = 0,
  max = 100,
  init = function(self)
    service.volume.get_async(function(result)
      local icon = theme.icons.get_volume(result.muted)
      self.icon = icon
      self.value = result.volume
    end)
  end,
  on_value_change = function(val)
    service.volume.set(val, "cc_slider")
  end,
  on_icon_press = function(_)
    service.volume.set("toggle")
  end,
}

awesome.connect_signal("service::volume", function(result, src)
  local icon = theme.icons.get_volume(result.muted)
  volume.icon = icon
  -- ignore self-emit signal
  if src ~= "cc_slider" then
    volume.value = result.volume
  end
end)

local brightness = slider {
  min = 0,
  max = 100,
  init = function(self)
    self.icon = theme.icons.brightness
    service.brightness.get_async(function(result)
      self.value = result.percentage
    end)
  end,
  on_value_change = function(val)
    service.brightness.set(val, "cc_slider")
  end,
}

awesome.connect_signal("service::brightness", function(result, src)
  -- local icon = theme.icons.get_volume(result.percentage)
  -- volume.icon = icon
  -- ignore self-emit signal
  if src ~= "cc_slider" then
    brightness.value = result.percentage
  end
end)

return wibox.widget {
  {
    {
      volume,
      brightness,
      spacing = dpi(12),
      layout = wibox.layout.fixed.vertical,
    },
    margins = dpi(12),
    widget = wibox.container.margin,
  },
  widget = wibox.container.background,
  forced_height = dpi(120),
  bg = theme.control_center.surface,
  -- border_color = beautiful.fg_normal, --.. "33",
  shape = utils.shape.rrect(),
}
