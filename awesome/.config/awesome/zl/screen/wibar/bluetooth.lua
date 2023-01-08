local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("zl.utils")
local theme = require("zl.theme")
local service = require("zl.service")

-- DEBUG
-- local SERVICE = "bluetooth"
local SERVICE = "bt"

local M = {}

local defaults = {
  fg = beautiful.fg_normal,
}

M.new = function(args)
  args = utils.table.extend(defaults, args or {})

  local widget = wibox.widget.textbox(theme.icons.bluetooth_off)
  awesome.connect_signal("service::" .. SERVICE, function(result)
    local icon = result.status ~= "off" and theme.icons.bluetooth or theme.icons.bluetooth_off
    local text = string.format("%s ", icon)
    widget.markup = utils.markup.fg(text, beautiful.palette.blue)
  end)

  -- tooltip
  local tip = awful.tooltip {
    ontop = true,
    objects = { widget },
    timeout = 5,
    timer_function = function()
      local content = {}
      local result = service[SERVICE].get()

      table.insert(content, string.format("Status: %s", result.status))
      for addr, dev in pairs(result.devices) do
        table.insert(content, ("%s(%s)"):format(addr, dev.Name))
      end

      return table.concat(content, "\n")
    end,
  }

  widget:buttons {
    awful.button({}, 1, function() -- left click
      service.bt.toggle()
    end),
  }

  return widget
end

return setmetatable(M, {
  __call = function(_, ...)
    return M.new(...)
  end,
})
