local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local service = require("zl.service")
local utils = require("zl.utils")

local defaults = {
  fg = beautiful.fg_normal,
}

local M = {}

M.new = function(args)
  args = utils.table.deep_extend(defaults, args or {})

  local bat = wibox.widget.textbox("bat")

  -- tooltip
  local bat_tip = awful.tooltip {
    ontop = true,
    objects = { bat },
    timer_function = function()
      local content = {}
      local result = service.battery.get()

      table.insert(content, string.format("State: %s%%(%s)", result.percentage, result.state))
      table.insert(content, string.format("Health: %s%%", result.health))

      if result.time ~= "N/A" then
        table.insert(content, string.format("Time left: %s", result.time))
      end
      if result.rate ~= "N/A" then
        table.insert(content, string.format("Energy rate: %.2f mW", result.rate))
      end

      return table.concat(content, "\n")
    end,
  }

  awesome.connect_signal("service::battery", function(result)
    -- local text = string.format(
    --   "[BAT] %s%%(%s %s) health(%s%%) rate(%s mW)",
    --   result.percentage,
    --   result.state,
    --   result.time,
    --   result.health,
    --   result.rate
    -- )
    local charging = false
    if result.state == "fully-charged" or result.state == "charging" then
      charging = true
    end
    local percentage = 100
    if result.percentage ~= "N/A" then
      percentage = result.percentage
    end
    local icon = utils.icons.battery(percentage, charging) .. " "
    bat.markup = utils.markup.fg(icon, args.fg)
  end)

  return bat
end

return setmetatable(M, {
  __call = function(_, ...)
    return M.new(...)
  end,
})
