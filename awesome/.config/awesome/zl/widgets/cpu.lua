local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("zl.utils")

local defaults = {
  fg = beautiful.fg_normal,
}

local factory = function(args)
  args = utils.table.deep_extend(defaults, args or {})
  local cpu = wibox.widget.textbox("cpu: ")
  awesome.connect_signal("service::cpu", function(result)
    local text = string.format("%s %s%%", utils.icons.cpu, result.usage)
    cpu.markup = utils.markup.fg(text, args.fg)
  end)
  return cpu
end

return factory
