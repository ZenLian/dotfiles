local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local utils = require("zl.utils")

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
    text = args.icon,
    -- fg = beautiful.fg_normal,
  }
  --
  local wtext = wibox.widget {
    widget = wibox.widget.textbox,
    align = "center",
    valign = "center",
    text = args.text,
    -- fg = beautiful.fg_normal,
  }
  --
  local widget = wibox.widget {
    {
      wicon,
      wtext,
      layout = wibox.layout.fixed.vertical,
    },
    widget = wibox.container.background,
    bg = beautiful.cc_widget_bg,
    shape = utils.shape.rrect(),
    forced_width = dpi(70),
    forced_height = dpi(70),
    -- width = dpi(200),
    -- height = dpi(200),
  }

  widget.enabled = false

  widget.toggle = function(self, value)
    if value == nil then
      value = not self.enabled
    end

    local old_value = self.enabled
    self.enabled = value
    if old_value ~= value then
      -- change color
      if value then
        self.bg = beautiful.palette.blue
      else
        self.bg = beautiful.cc_widget_bg
      end
      -- user callback
      if args.toggle then
        args.toggle(value)
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

  widget:connect_signal("property::enabled", function(_, value)
    if value then
      widget.bg = beautiful.palette.blue
    else
      widget.bg = beautiful.cc_widget_bg
    end
  end)

  return widget

  -- local button = {
  --   status = "off",
  --   widget = widget,
  --   wicon = wicon,
  --   wtext = wtext,
  -- }

  -- return setmetatable(button, { __index = M })
end

return setmetatable(M, {
  __call = function(_, ...)
    return M.new(...)
  end,
})
