local beautiful = require("beautiful")
local lain = require("lain")
local utils = require("zl.utils")

local defaults = {
  fg = beautiful.fg_normal,
}

local factory = function(args)
  args = utils.table.deep_extend(defaults, args or {})

  local vol = lain.widget.alsa {
    cmd = "amixer -D pulse",
    settings = function()
      local icon = volume_now.status == "on" and "墳" or "婢"
      local text = string.format("%s %s%%", icon, volume_now.level)
      widget:set_markup(lain.util.markup.fg(args.fg, text))
    end,
  }

  -- TODO: put alsa into one module
  -- for keys
  awesome.connect_signal("system::volume", function()
    vol.update()
  end)

  return vol.widget
end

return factory
