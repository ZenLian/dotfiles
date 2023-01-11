local awful = require("awful")
local naughty = require("naughty")
-- local beautiful = require("beautiful")
local theme = require("zl.theme")
local ruled = require("ruled")

local M = {}

naughty.config.presets.critical = {
  bg = theme.color.error,
  fg = theme.color.on_error,
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
