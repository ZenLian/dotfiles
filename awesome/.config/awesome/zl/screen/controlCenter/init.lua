local M = {}

local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("zl.utils")

M.inited = false

function M.setup()
  if M.inited then
    return
  end
  awful.screen.connect_for_each_screen(function(s)
    s.mycc = wibox {
      type = "dock",
      shape = utils.shape.rrect(),
      screen = s,
      width = beautiful.cc_width,
      height = beautiful.cc_height,
      bg = beautiful.cc_bg,
      -- margins = dpi(20),
      x = s.geometry.x + beautiful.useless_gap,
      y = s.geometry.y + beautiful.wibar_height + beautiful.useless_gap,
      ontop = true,
      visible = false,
    }

    -- widgets
    local sliders = require("zl.screen.controlCenter.sliders")

    s.mycc:setup {
      {
        sliders,
        layout = wibox.layout.fixed.vertical,
      },
      widget = wibox.container.margin,
      margins = beautiful.cc_spacing,
    }
  end)

  M.inited = true
end

M.toggle = function(s)
  if not M.inited then
    M.setup()
  end

  if not s then
    s = screen.primary
  end

  local cc = s.mycc

  -- cc.x = s.geometry.x + (dpi(48) + beautiful.useless_gap * 4)
  -- cc.y = s.geometry.y + s.geometry.height - (cc.height + beautiful.useless_gap * 2)
  cc.visible = not cc.visible

  local notify = {
    title = "cc",
    -- stylua: ignore
    text = string.format("visible: %s\n", cc.visible)
        .. string.format("pos: (%s, %s)\n", cc.x, cc.y)
        .. string.format("width: %s, height: %s", cc.width, cc.height)
,
  }
  -- require("naughty").notify(notify)
end

return M
