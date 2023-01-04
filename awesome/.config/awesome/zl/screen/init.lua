-- appearences each screen
local awful = require("awful")

require(... .. ".wallpaper")

-- {{{ tags
-- TODO: move to tags
local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

-- default tags

screen.connect_signal("request::desktop_decoration", function(s)
  screen[s].padding = { left = 0, right = 0, top = 0, bottom = 0 }
  awful.tag(tags, s, awful.layout.layouts[1])
end)
-- }}}

require("zl.screen.wibar")
require("zl.screen.titlebar")
require("zl.screen.controlCenter")
require("zl.screen.notification")
