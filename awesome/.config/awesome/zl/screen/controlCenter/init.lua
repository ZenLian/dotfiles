local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme = require("zl.theme")
local utils = require("zl.utils")
local PREFIX = ...

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
    width = theme.control_center.width,
    height = theme.control_center.height,
    bg = theme.control_center.bg,
    -- margins = dpi(20),
    ontop = true,
    visible = false,
    -- opacity = 0.95,
  }
  s.mycc = mycc

  mycc.x = s.geometry.x + s.geometry.width - mycc.width - beautiful.useless_gap
  mycc.y = s.geometry.y + theme.wibar.height + beautiful.useless_gap

  -- widgets
  local sliders = require(PREFIX .. ".sliders")
  local switchers = require(PREFIX .. ".switchers")

  mycc:setup {
    {
      sliders,
      switchers,
      layout = wibox.layout.fixed.vertical,
      spacing = theme.control_center.spacing,
    },
    widget = wibox.container.margin,
    margins = theme.control_center.spacing,
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
