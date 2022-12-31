local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local utils = require("zl.utils")
local service = require("zl.service")
local O = require("zl.configs").options

local defaults = {
  fg = beautiful.fg_normal,
}

local factory = function(args)
  args = utils.table.deep_extend(defaults, args or {})

  local vol = wibox.widget.textbox("vol")

  awesome.connect_signal("service::volume", function(result)
    local icon = utils.icons.volume(result.muted)
    local text = string.format("%s %s%%", icon, result.volume)
    local markup = utils.markup.fg(text, args.fg)
    vol.markup = markup
    -- local naughty = require("naughty")
    -- naughty.notify {
    --   title = "service::volume",
    --   text = markup,
    -- }
  end)

  vol:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- left click
      service.volume.set("toggle")
    end),
    awful.button({}, 2, function() -- middle click
      service.volume.set(100)
    end),
    awful.button({}, 3, function() -- right click
      -- TODO:
      awful.spawn(O.apps.terminal .. " -e alsamixer")
    end),
    awful.button({}, 4, function() -- scroll up
      service.volume.set("1%+")
    end),
    awful.button({}, 5, function() -- scroll down
      service.volume.set("1%-")
    end)
  ))

  return vol
end

return factory
