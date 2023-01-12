local wibox = require("wibox")
local theme = require("zl.theme")
local naughty = require("naughty")
local button = require(... .. ".button")
local service = require("zl.service")

local wifi = button {
  icon = theme.icons.wifi,
  text = "wifi",
  on_toggle = function(value)
    -- service.network.
    naughty.notification {
      text = "turn " .. tostring(value),
    }
  end,
}

-- awesome.connect_signal("service::network", function(devices)
--   local DEVICE = require("zl.config").device.wifi
--   local dev = devices and devices[DEVICE]
--   if not dev then
--     return
--   end
--   if dev.wifi then
--     wifi.enabled = true
--   else
--     wifi.enabled = false
--   end
-- end)

local bluetooth = button {
  icon = theme.icons.bluetooth,
  text = "bluetooth",
  on_toggle = function(value)
    service.bluetooth.toggle(value)
  end,
}

awesome.connect_signal("service::bluetooth", function(result)
  local status = result.status
  if status == "off" then
    bluetooth:set_enabled(false)
  else
    bluetooth:set_enabled(true)
  end
end)

return wibox.widget {
  wifi,
  bluetooth,
  layout = wibox.layout.fixed.horizontal,
  spacing = theme.control_center.spacing,
}
