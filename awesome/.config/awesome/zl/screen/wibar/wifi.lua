local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local wibox = require("wibox")
local utils = require("zl.utils")
local theme = require("zl.theme")

local defaults = {
  fg = beautiful.fg_normal,
  device = "wlan0",
}

local factory = function(args)
  args = utils.table.extend(defaults, args or {})

  local wifi = wibox.widget.imagebox()

  awesome.connect_signal("service::network", function(devices)
    local dev = devices and devices[args.device]
    if not dev then
      return
    end
    if dev.wifi then
      local image = theme.icons.get_mdi_wifi(dev.wifi.level, args.fg)
      wifi:set_image(image)
    else
      local image = theme.icons.get_mdi("wifi-off", args.fg)
      wifi:set_image(image)
    end
  end)

  -- awful.tooltip {
  --   ontop = true,
  --   objects = { net },
  --   timer_function = function()
  --     local text = {}
  --     local devices = service.network.devices
  --     for name, dev in pairs(devices) do
  --       local line = string.format("%s: %s  %s 祝%s", name, dev.state, dev.down, dev.up)
  --       if dev.wifi then
  --         line = line .. string.format(" signal(%s%%)", dev.wifi.signal)
  --       end
  --       table.insert(text, line)
  --     end
  --     return table.concat(text, "\n")
  --   end,
  -- }

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
