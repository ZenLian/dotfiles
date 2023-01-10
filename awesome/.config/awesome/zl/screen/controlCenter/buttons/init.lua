local wibox = require("wibox")
local theme = require("zl.theme")
local naughty = require("naughty")
local button = require(... .. ".button")
local service = require("zl.service")

local DEVICE = require("zl.config").device.wifi

local wifi = button {
  icon = theme.icons.wifi,
  text = "wifi",
  -- init = function(self)
  --   local devices = service.network.get()
  --   return
  -- end,
  toggle = function(value)
    -- service.network.
    naughty.notification {
      text = "turn " .. tostring(value),
    }
  end,
}

-- awesome.connect_signal("service::network", function(devices)
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

return wibox.widget {
  wifi,
  layout = wibox.layout.fixed.horizontal,
}
