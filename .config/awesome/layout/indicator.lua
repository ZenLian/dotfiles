local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")
local widget = require("widget")
local config = require("config")
local naughty = require("naughty")
local utils = require("utils")
local theme = require("theme")

local M = {}

M.new = function(s)
  local popup = awful.popup {
    widget = wibox.widget {
      widget = wibox.container.background,
      forced_width = dpi(80),
      forced_height = dpi(80),
      -- shape = utils.shape.rrect(8),
      bg = theme.palette.surface0 .. "33",
      {
        widget = wibox.container.margin,
        margins = dpi(10),
        {
          id = "imagebox",
          widget = wibox.widget.imagebox,
          image = theme.icons("lock-off-outline"),
        },
      },
    },
    screen = s,
    placement = function(d, args)
      args.margins = dpi(20)
      return awful.placement.bottom(d, args)
    end,
    ontop = true,
    visible = false,
    shape = utils.shape.rrect(dpi(5)),
    bg = theme.palette.surface0 .. "33",
  }

  local indicator = setmetatable({}, { __index = M })
  indicator.popup = popup

  indicator.timer = gears.timer {
    timeout = 3,
    single_shot = true,
    callback = function()
      indicator.popup.visible = false
      -- indicator.timer:stop()
    end,
  }
  return indicator
end

M.show = function(self, capslock)
  local imagebox = self.popup.widget:get_children_by_id("imagebox")[1]
  if capslock == "on" then
    imagebox.image = theme.icons("lock-outline")
  else
    imagebox.image = theme.icons("lock-off-outline")
  end
  self.popup.visible = true
  self.timer:again()
end

awesome.connect_signal("service::xset", function(result)
  local indicator = awful.screen.focused().indicator
  indicator:show(result.capslock)
end)

return setmetatable(M, {
  __call = function(_, ...)
    return M.new(...)
  end,
})
