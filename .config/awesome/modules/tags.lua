local awful = require("awful")
local beautiful = require("beautiful")
local icons = require("theme.icons")
local config = require("config")

local tags = {
  {
    name = "terminal",
    icon = icons.console,
    app = config.apps.terminal,
  },
  {
    name = "code",
    icon = icons.code,
    app = config.apps.editor,
  },
  {
    name = "web",
    icon = icons.web,
    app = config.apps.browser,
  },
  {
    name = "files",
    icon = icons.files,
    app = config.apps.explorer,
  },
  {
    name = "music",
    icon = icons.music,
  },
  {
    name = "lab",
    icon = icons.lab,
  },
}

-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
  awful.layout.append_default_layouts {
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.spiral.name,
    awful.layout.suit.tile.right,
    awful.layout.suit.floating,
    -- awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.fair,
  }
end)

screen.connect_signal("request::desktop_decoration", function(s)
  -- screen[s].padding = { left = 0, right = 0, top = 0, bottom = 0 }
  -- awful.tag(tags, s, awful.layout.layouts[1])
  for i, tag in ipairs(tags) do
    awful.tag.add(tag.icon, {
      screen = s,
      layout = awful.layout.layouts[1],
      gap_single_client = false,
      gap = beautiful.useless_gap,
      selected = i == 1,
    })
  end
end)
