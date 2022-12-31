local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")

-- {{{ wallpaper
--------------
screen.connect_signal("request::wallpaper", function(s)
  awful.wallpaper {
    screen = s,
    widget = {
      image = beautiful.wallpaper,
      widget = wibox.widget.imagebox,
      upscale = true,
      downscale = true,
      horizontal_fit_policy = "fit",
      vertical_fit_policy = "fit",
    },
  }
end)
-- }}}

-- {{{ tags
-- TODO: move to tags
local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

-- default tags
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.fair,
  }
end)

-- layout popup
local layout_popup = require("zl.widgets.layout")()
awesome.connect_signal("zl::layout_visible", function(visible)
  layout_popup.visible = visible
end)

screen.connect_signal("request::desktop_decoration", function(s)
  screen[s].padding = { left = 0, right = 0, top = 0, bottom = 0 }
  awful.tag(tags, s, awful.layout.layouts[1])
end)
-- }}}

require("zl.screen.wibar")
require("zl.screen.titlebar")
require("zl.screen.controlCenter")
require("zl.screen.notification")
