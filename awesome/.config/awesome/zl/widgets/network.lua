local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local lain = require("lain")
local gears = require("gears")
local recolor_image = gears.color.recolor_image
local utils = require("zl.utils")
local mdi = utils.mdi

local defaults = {
  fg = beautiful.fg_normal,
}

local factory = function(args)
  args = utils.table.deep_extend(defaults, args or {})

  local wifi = wibox.widget.imagebox()
  local wifi_widget = wibox.widget {
    wifi,
    margins = {
      top = dpi(8),
      bottom = dpi(8),
    },
    widget = wibox.container.margin,
  }

  local wifi_icons = {
    { -83, recolor_image(mdi("wifi-strength-1"), args.fg) },
    { -70, recolor_image(mdi("wifi-strength-2"), args.fg) },
    { -53, recolor_image(mdi("wifi-strength-3"), args.fg) },
    { 0, recolor_image(mdi("wifi-strength-4"), args.fg) },
  }
  local wifi_off = recolor_image(mdi("wifi-off"), args.fg)

  -- wrap lain
  lain.widget.net {
    notify = "off",
    iface = { "wlan0" },
    wifi_state = "on",
    eth_state = "on",
    settings = function()
      -- TODO: autoselect device
      local wlan = net_now.devices.wlan0
      if wlan then
        if wlan.wifi and wlan.signal then
          local signal = wlan.signal
          for _, v in ipairs(wifi_icons) do
            if signal < v[1] then
              wifi:set_image(v[2])
              break
            end
          end
        else
          wifi:set_image(wifi_off)
        end
      end
    end,
  }

  awful.tooltip {
    ontop = true,
    objects = { wifi_widget },
    timer_function = function()
      local text = {}
      table.insert(text, string.format("State: %s", net_now.state))
      if net_now.state == "up" then
        table.insert(text, string.format(" %s kB/s", net_now.sent))
        table.insert(text, string.format("祝 %s kB/s", net_now.received))
      end
      return table.concat(text, "\n")
    end,
  }

  return wifi_widget
end

return factory
