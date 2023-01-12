local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("zl.utils")
local theme = require("zl.theme")

local M = {}

local defaults = {
  icon = "",
  text = "",
}

function M.new(args)
  args = utils.table.extend(defaults, args)

  local wicon = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    font = utils.icon_font(28),
    text = args.icon,
  }
  --
  local wtext = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    font = utils.font(12),
    text = args.text,
  }
  --
  local widget = wibox.widget {
    {
      wicon,
      wtext,
      layout = wibox.layout.fixed.vertical,
      spacing = dpi(10),
      -- layout = wibox.layout.align.vertical,
      -- expand = "none",
    },
    widget = wibox.container.background,
    bg = theme.color.surface,
    shape = utils.shape.rrect(),
    forced_width = dpi(90),
    forced_height = dpi(90),
    -- width = dpi(200),
    -- height = dpi(200),
  }

  widget.enabled = false
  -- without user action
  function widget:set_enabled(value)
    rawset(widget, "enabled", value)
    -- change color
    if value then
      self.bg = theme.color.primary
      self.fg = theme.color.on_primary
    else
      self.bg = theme.color.surface
      self.fg = theme.color.on_surface
    end
  end

  function widget:toggle(value)
    if value == nil then
      value = not self.enabled
    end

    local old_value = self.enabled
    self:set_enabled(value)
    if old_value ~= value then
      -- user callback
      if args.on_toggle then
        args.on_toggle(value)
      end
    end
  end

  widget:buttons {
    awful.button({}, 1, function()
      widget:toggle()
      -- widget.bg = beautiful.palette.blue
      -- widget.enabled = not widget.enabled
    end),
  }

  return widget
end

return setmetatable(M, {
  __call = function(_, ...)
    return M.new(...)
  end,
})
