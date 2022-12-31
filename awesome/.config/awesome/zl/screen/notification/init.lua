local naughty = require("naughty")
local beautiful = require("beautiful")

naughty.config.presets.critical = {
  bg = beautiful.notification_bg_critical,
  fg = beautiful.notification_fg_critical,
  timeout = 0,
}
