local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local utils = require("zl.utils")
local theme = require("zl.theme")
local service = require("zl.service")
local config = require("zl.config")

local defaults = {
  fg = beautiful.fg_normal,
  device = config.device.wifi,
}

local factory = function(args)
  args = utils.table.extend(defaults, args or {})

  local wifi = wibox.widget {
    widget = wibox.widget.textbox(),
    font = utils.icon_font(),
    markup = theme.icons.wifi_off,
  }

  awesome.connect_signal("service::nm", function(devices)
    local dev = devices and devices[args.device]
    if not dev then
      return
    end
    if dev.state == "ACTIVATED" then
      local icon = theme.icons.get_wifi(dev.wifi.strength or 100)
      wifi:set_markup(utils.markup.fg(icon, args.fg))
    else
      local icon = theme.icons.wifi_off
      wifi:set_markup(utils.markup.fg(icon, args.fg))
    end
  end)

  awful.tooltip {
    ontop = true,
    objects = { wifi },
    timer_function = function()
      local dev = service.nm.devices[args.device]
      local text = {}
      table.insert(text, string.format("%s: %s", dev.name, dev.state))
      table.insert(text, string.format("%s(%s)", dev.wifi.name, dev.wifi.strength))
      -- text[#text + 1] = "bitrate" --string.format("%s bit/s", dev.wifi.bitrate)
      return table.concat(text, "\n")
    end,
  }

  return wibox.widget {
    wifi,
    margins = {
      top = dpi(8),
      bottom = dpi(8),
    },
    widget = wibox.container.margin,
  }
end

return factory
