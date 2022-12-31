local awful = require("awful")
local beautiful = require("beautiful")
local utils = require("zl.utils")
local lain = require("lain")

local defaults = {
  fg = beautiful.fg_normal,
  timeout = 7,
}

local factory = function(args)
  args = utils.table.deep_extend(defaults, args or {})

  local bat = lain.widget.bat {
    timeout = args.timeout,
    n_perc = { 10, 20 },
    full_notify = "off",
    settings = function()
      local charging = bat_now.status == "Charging" or bat_now.status == "Full"
      local perc = bat_now.perc == "N/A" and 100 or bat_now.perc
      local icon = utils.icons.battery(perc, charging)
      local text = icon .. " "
      widget:set_markup(lain.util.markup.fg(args.fg, text))
    end,
  }

  -- tooltip
  awful.tooltip {
    ontop = true,
    objects = { bat.widget },
    timer_function = function()
      local content = {}

      local status = bat_now.status
      content[#content + 1] = string.format("Status: %s%%(%s)", bat_now.perc, status)
      -- content[#content + 1] = string.format("Capacity: %s%%", bat_now.capacity)

      if status == "Discharging" then
        if bat_now.time ~= "N/A" then
          content[#content + 1] = string.format("Time remaining: %s", bat_now.time)
        end
        if bat_now.watt ~= "N/A" then
          content[#content + 1] = string.format("Power: %s Watt", bat_now.watt)
        end
      end

      return table.concat(content, "\n")
    end,
  }

  return bat.widget
end

return factory
