local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("zl.utils")

local M = {
  _setup = false,
  -- show in which screen
  screen = nil,
}

-- add to screen
M.create = function(s)
  local mycc = wibox {
    type = "dock",
    shape = utils.shape.rrect(),
    screen = s,
    width = beautiful.cc_width,
    height = beautiful.cc_height,
    bg = beautiful.cc_bg,
    -- margins = dpi(20),
    ontop = true,
    visible = false,
    -- opacity = 0.95,
  }
  s.mycc = mycc

  mycc.x = s.geometry.x + s.geometry.width - mycc.width - beautiful.useless_gap
  mycc.y = s.geometry.y + beautiful.wibar_height + beautiful.useless_gap

  -- widgets
  local sliders = require("zl.screen.controlCenter.sliders")

  mycc:setup {
    {
      sliders,
      layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.margin,
    margins = beautiful.cc_spacing,
  }

  mycc:buttons {
    awful.button({}, 3, function()
      M.hide()
    end),
  }

  return mycc
end

function M.hide()
  if M.screen then
    M.screen.mycc.visible = false
  end
  M.screen = nil
end

function M.show(s)
  s = s or screen.primary

  if M.screen ~= s then
    M.hide()
  end
  s.mycc.visible = true
  M.screen = s
end

function M.toggle(s)
  if M.screen == nil or M.screen ~= s then
    M.show(s)
  else
    M.hide()
  end
end

function M.setup()
  if M._setup then
    return
  end

  -- add to screen
  awful.screen.connect_for_each_screen(function(s)
    M.create(s)
  end)

  screen.connect_signal("request::remove", function(s)
    if M.screen == s then
      M.hide()
    end
  end)

  M._setup = true
end

return M
