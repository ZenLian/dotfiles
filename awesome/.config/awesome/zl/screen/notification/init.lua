local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")
local ruled = require("ruled")

local M = {}

naughty.config.presets.critical = {
  bg = beautiful.notification_bg_critical,
  fg = beautiful.notification_fg_critical,
  timeout = 0,
}

-- {{{ Notifications
ruled.notification.connect_signal("request::rules", function()
  -- All notifications will match this rule.
  ruled.notification.append_rule {
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
    },
  }
end)

naughty.connect_signal("request::display", function(n)
  naughty.layout.box { notification = n }
end)
-- }}}

return M
