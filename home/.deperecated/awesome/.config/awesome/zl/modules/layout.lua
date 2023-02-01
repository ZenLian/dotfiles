local awful = require("awful")

-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
    -- awful.layout.suit.fair,
  }
end)

-- layout popup
local layout_popup = require("zl.widgets.layout")()
awesome.connect_signal("zl::layout_visible", function(visible)
  layout_popup.visible = visible
end)
