local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local modkey = require("zl.configs").options.keys.modkey
local theme = require("zl.theme")
local utils = require("zl.utils")
local widgets = {
  volume = require(... .. ".volume"),
  battery = require(... .. ".battery"),
  wifi = require(... .. ".wifi"),
}

local spacer = function(n)
  local spaces = string.rep(" ", n or 1)
  return wibox.widget.textbox(spaces)
end

local clk = wibox.widget.textclock("%H:%M")

local vol = widgets.volume {
  fg = beautiful.palette.green,
}

local bat = widgets.battery {
  fg = beautiful.palette.teal,
}

local wifi = widgets.wifi {
  fg = beautiful.palette.blue,
}

local cpu = wibox.widget.textbox()
awesome.connect_signal("service::cpu", function(result)
  local text = string.format("%s %s%%", theme.icons.cpu, result.usage)
  cpu.markup = utils.markup.fg(text, beautiful.palette.lavender)
end)

local mem = wibox.widget.textbox()
awesome.connect_signal("service::memory", function(result)
  local text = string.format("%s %s%%", theme.icons.memory, result.perc)
  mem.markup = utils.markup.fg(text, beautiful.palette.yellow)
end)

local thermal = wibox.widget.textbox()
awesome.connect_signal("service::thermal", function(result)
  local text = string.format("%s %s°C", theme.icons.thermal, result.thermal)
  thermal.markup = utils.markup.fg(text, beautiful.palette.pink)
end)

local wb_systat = wibox.widget {
  cpu,
  mem,
  thermal,
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(10),
}

local wb_control = wibox.widget {
  vol,
  wifi,
  bat,
  -- kbd,
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(10),
}

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

screen.connect_signal("request::desktop_decoration", function(s)
  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox {
    screen = s,
    buttons = {
      awful.button({}, 1, function()
        awful.layout.inc(1)
      end),
      awful.button({}, 3, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, 4, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, 5, function()
        awful.layout.inc(1)
      end),
    },
  }

  s.wb_taglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    widget_template = {
      {
        {
          {
            id = "text_role",
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        left = dpi(8),
        right = dpi(8),
        -- margins = dpi(8),
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      -- Add support for hover colors and an index label
      create_callback = function(self, c3, index, objects) --luacheck: no unused args
        -- self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
        self:connect_signal("mouse::enter", function()
          if self.bg ~= beautiful.taglist_bg_hover then
            self.old_bg = self.bg
          end
          self.bg = beautiful.taglist_bg_hover
        end)
        self:connect_signal("mouse::leave", function()
          if self.old_bg then
            self.bg = self.old_bg
            self.old_bg = nil
          end
        end)
      end,
      -- update_callback = function(self, c3, index, objects) --luacheck: no unused args
      -- 	self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
      -- end,
    },
    buttons = taglist_buttons,
  }

  -- Create a tasklist widget
  s.wb_tasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    widget_template = {
      {
        {
          id = "icon_role",
          widget = wibox.widget.imagebox,
        },
        margins = { left = dpi(8), right = dpi(8), top = dpi(3), bottom = dpi(3) },
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
    buttons = {
      awful.button({}, 1, function(c)
        c:activate { context = "tasklist", action = "toggle_minimization" }
      end),
      awful.button({}, 3, function()
        awful.menu.client_list { theme = { width = 250 } }
      end),
      awful.button({}, 4, function()
        awful.client.focus.byidx(-1)
      end),
      awful.button({}, 5, function()
        awful.client.focus.byidx(1)
      end),
    },
  }

  if s == screen.primary then
    s.wb_systat = wb_systat
  end

  -- Create the wibox
  s.wibar = awful.wibar {
    screen = s,
    visible = true,
    ontop = false,
    type = "dock",
    -- width = s.geometry.width - beautiful.useless_gap * 5,
    height = beautiful.wibar_height,
    -- shape = utils.shape.rrect(beautiful.border_radius / 2),
    bg = beautiful.wibar_bg,
    -- margins = { left = dpi(10), right = dpi(10), top = dpi(10), bottom = dpi(14) },
  }

  s.wibar:setup {
    -- Left
    {
      s.wb_taglist,
      layout = wibox.layout.fixed.horizontal,
    },
    -- Middle
    s.wb_tasklist,
    -- Right
    {
      {
        {
          widget = wibox.widget.systray {
            reverse = true,
          },
        },
        widget = wibox.container.margin,
        margins = dpi(4),
      },
      s.wb_systat,
      wb_control,
      clk,
      spacer(),
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(10),
    },
    layout = wibox.layout.align.horizontal,
    expand = "none",
  }
end)
