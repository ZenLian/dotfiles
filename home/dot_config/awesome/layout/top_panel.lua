local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local widget = require("widget")
local icons = require("theme.icons")
local utils = require("utils")
local comp = require("theme.comp")

local top_panel = function(s)
  local panel = awful.wibar {
    screen = s,
    visible = true,
    ontop = false,
    type = "dock",
    height = dpi(32),
    bg = beautiful.bg_normal,
    fg = beautiful.fg_normal,
  }

  s.taglist = widget.taglist(s)
  s.tasklist = widget.tasklist(s)

  -- {{{ TODO: systat: move to somewhere else
  local cpu = widget.iconic {
    icon = icons.cpu,
    desc = "N/A",
    fg = comp.wibar.cpu.fg,
  }
  awesome.connect_signal("service::cpu", function(result)
    local text = string.format("%s%%", result.usage)
    cpu.desc.markup = utils.markup.fg(text, comp.wibar.cpu.fg)
  end)

  local mem = widget.iconic {
    icon = icons.memory,
    desc = "N/A",
    fg = comp.wibar.memory.fg,
  }
  awesome.connect_signal("service::memory", function(result)
    local text = string.format("%s%%", result.perc)
    mem.desc.markup = utils.markup.fg(text, comp.wibar.memory.fg)
  end)

  local thermal = widget.iconic {
    icon = icons.memory,
    desc = "N/A",
    fg = comp.wibar.thermal.fg,
  }
  awesome.connect_signal("service::thermal", function(result)
    local text = string.format("%s°C", result.thermal)
    thermal.desc.markup = utils.markup.fg(text, comp.wibar.thermal.fg)
  end)

  s.systat = wibox.widget {
    {
      cpu,
      mem,
      thermal,
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(10),
    },
    -- bg = comp.wibar.systat.bg,
    widget = wibox.widget.background,
  }
  --}}}

  s.volume = widget.volume()
  s.battery = widget.battery()
  s.wifi = widget.wifi()
  s.bluetooth = widget.bluetooth()
  s.syscontrol = wibox.widget {
    s.volume,
    s.bluetooth,
    s.wifi,
    s.battery,
    layout = wibox.layout.fixed.horizontal,
    spacing = dpi(10),
  }

  s.clock = widget.clock(s)
  s.systray = wibox.widget {
    widget = wibox.container.margin,
    left = dpi(5),
    right = dpi(5),
    top = dpi(7),
    bottom = dpi(7),
    {
      widget = wibox.widget.systray,
      reverse = true,
      screen = "primary",
    },
  }

  panel:setup {
    layout = wibox.layout.align.horizontal,
    -- expand = "none",
    {
      layout = wibox.layout.fixed.horizontal,
      s.taglist,
    },
    {
      layout = wibox.layout.fixed.horizontal,
      s.tasklist,
    },
    {
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(10),
      s.systray,
      s.systat,
      s.syscontrol,
      s.clock,
    },
  }

  return panel
end

return top_panel
