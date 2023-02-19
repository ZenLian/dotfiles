local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local comp = require("zl.theme.comp")
local icons = require("zl.theme.icons")
local utils = require("zl.utils")
local wdg = require("zl.widgets")
local widgets = {
  volume = require(... .. ".volume"),
  battery = require(... .. ".battery"),
  wifi = require(... .. ".wifi"),
  bluetooth = require(... .. ".bluetooth"),
}

local M = {}

local modkey = require("zl.config").keys.modkey

local spacer = function(n)
  local spaces = string.rep(" ", n or 1)
  return wibox.widget.textbox(spaces)
end

local clk = wibox.widget.textclock("%m-%d %H:%M")

local vol = widgets.volume {}

local bat = widgets.battery {}

local wifi = widgets.wifi {
  fg = comp.wibar.wifi.fg,
}

local bluetooth = widgets.bluetooth {
  fg = comp.wibar.bluetooth.fg,
}

local cpu = wdg.iconic {
  icon = icons.cpu,
  desc = "N/A",
  fg = comp.wibar.cpu.fg,
}
awesome.connect_signal("service::cpu", function(result)
  local text = string.format("%s%%", result.usage)
  cpu.desc.markup = utils.markup.fg(text, comp.wibar.cpu.fg)
end)

local mem = wdg.iconic {
  icon = icons.memory,
  desc = "N/A",
  fg = comp.wibar.memory.fg,
}
awesome.connect_signal("service::memory", function(result)
  local text = string.format("%s%%", result.perc)
  mem.desc.markup = utils.markup.fg(text, comp.wibar.memory.fg)
end)

local thermal = wdg.iconic {
  icon = icons.memory,
  desc = "N/A",
  fg = comp.wibar.thermal.fg,
}
awesome.connect_signal("service::thermal", function(result)
  local text = string.format("%s°C", result.thermal)
  thermal.desc.markup = utils.markup.fg(text, comp.wibar.thermal.fg)
end)

local wb_systat = wibox.widget {
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

local wb_control = wibox.widget {
  vol,
  bluetooth,
  wifi,
  bat,
  -- kbd,
  layout = wibox.layout.fixed.horizontal,
  spacing = dpi(10),
}

local wb_systray = wibox.widget {
  -- {
  --   widget = wibox.widget.systray {
  --     reverse = true,
  --   },
  -- },
  {
    wibox.widget.systray {
      reverse = true,
      -- bg = comp.wibar.bg,
    },
    widget = wibox.container.margin,
    margins = {
      left = dpi(5),
      right = dpi(5),
    },
  },
  -- bg = comp.wibar.bg,
  bg = comp.wibar.systray.bg,
  -- shape = utils.shape.rrect(dpi(5)),
  widget = wibox.container.background,
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

M.init = function(s)
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
      create_callback = function(self, c, index, objects) --luacheck: no unused args
        -- self:get_children_by_id("index_role")[1].markup = "<b> " .. c3.index .. " </b>"
        self:connect_signal("mouse::enter", function()
          if self.bg ~= comp.taglist.hover.bg then
            self.old_bg = self.bg
          end
          self.bg = comp.taglist.hover.bg
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
    layout = {
      spacing = dpi(3),
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        -- {
        --   id = "icon_role",
        --   widget = wibox.widget.imagebox,
        -- },
        -- {
        --   id = "text_role",
        --   widget = wibox.widget.textbox,
        -- },
        {
          id = "clientclass",
          widget = wibox.widget.textbox,
        },
        -- margins = { left = dpi(8), right = dpi(8), top = dpi(3), bottom = dpi(3) },
        margins = dpi(3),
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      create_callback = function(self, c)
        self:get_children_by_id("clientclass")[1].markup = c.class
      end,
      -- update_callback = function(self, c)
      --   self:get_children_by_id("clientclass")[1].markup = c.class
      -- end,
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
    height = comp.wibar.height,
    -- shape = utils.shape.rrect(beautiful.border_radius / 2),
    bg = comp.wibar.bg,
    -- margins = { left = dpi(10), right = dpi(10), top = dpi(10), bottom = dpi(14) },
  }

  s.wibar:setup {
    -- Left
    {
      s.wb_taglist,
      layout = wibox.layout.fixed.horizontal,
    },
    -- Middle
    {
      s.wb_tasklist,
      -- widget = wibox.container.background,
      layout = wibox.layout.fixed.horizontal,
    },
    -- Right
    {
      s.wb_systat,
      wb_control,
      clk,
      wb_systray,
      -- spacer(),
      layout = wibox.layout.fixed.horizontal,
      spacing = dpi(10),
    },
    layout = wibox.layout.align.horizontal,
    -- expand = "none",
  }
end

return M
