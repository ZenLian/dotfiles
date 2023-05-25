local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local dpi = beautiful.xresources.apply_dpi
local config = require("config")
local modkey = require("config").keys.modkey
local theme = require("theme")
local utils = require("utils")

local total_height = config.layout.top_panel.height
local indicator_height = 2

local taglist_buttons = {
  awful.button({}, 1, function(t)
    t:view_only()
  end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then
      client.focus:move_to_tag(t)
    end
  end),
  awful.button({}, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then
      client.focus:toggle_tag(t)
    end
  end),
  awful.button({}, 4, function(t)
    awful.tag.viewprev(t.screen)
  end),
  awful.button({}, 5, function(t)
    awful.tag.viewnext(t.screen)
  end),
}

local taglist_update = function(self, t, index, objects)
  local indicator = self:get_children_by_id("indicator")[1]
  if t.selected then
    indicator.color = theme.palette.blue
  else
    indicator.color = theme.palette.base
  end
end

local taglist = function(s)
  return awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    style = {
      fg_urgent = theme.palette.red,
    },
    widget_template = {
      layout = wibox.layout.align.vertical,
      forced_width = dpi(26),
      {
        id = "background_role",
        widget = wibox.container.background,
        forced_height = dpi(total_height - indicator_height),
        {
          id = "text_margin_role",
          widget = wibox.container.margin,
          left = dpi(5),
          right = dpi(5),
          {
            id = "text_role",
            widget = wibox.widget.textbox,
            -- align = "center",
            -- font = utils.icon_font(12),
          },
        },
      },
      {
        id = "indicator",
        widget = wibox.widget.separator,
        orientation = "horizontal",
        thickness = dpi(2),
        -- forced_width = dpi(20),
        span_ratio = 1,
      },
      nil,
      create_callback = function(self, t, index, objects) --luacheck: no unused args
        local mainbox = self:get_children_by_id("background_role")[1]
        self:connect_signal("mouse::enter", function()
          mainbox.bg = theme.palette.surface0
        end)
        self:connect_signal("mouse::leave", function()
          mainbox.bg = theme.palette.base
        end)
        taglist_update(self, t, index, objects)
      end,
      update_callback = taglist_update,
    },
  }
end

return taglist
-- return taglist_new
