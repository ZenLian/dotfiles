local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local modkey = require("zl").options.keys.modkey
local utils = require("zl.utils")
local lain = require("lain")
local markup = lain.util.markup

-- {{{ Wibar
local spacer = wibox.widget.textbox(" ")

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
local mytextclock = wibox.widget.textclock()

-- local cpu = lain.widget.cpu() --{
-- timeout = 1,
-- settings = function()
--   widget:set_markup(markup.fontfg(beautiful.font, beautiful.yellow, " " .. cpu_now.usage .. "%"))
-- end,
-- }
local cpu = lain.widget.cpu {
  settings = function()
    widget:set_markup(" " .. cpu_now.usage .. "%")
  end,
}

local mem = lain.widget.mem {
  timeout = 1,
  settings = function()
    -- widget:set_markup(markup.fontfg(beautiful.font, beautiful.blue, " " .. mem_now.perc .. "%"))
    widget:set_markup(" " .. mem_now.perc .. "%")
  end,
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
  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

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

  s.mytaglist = awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    widget_template = {
      {
        {
          {
            {
              id = "icon_role",
              widget = wibox.widget.imagebox,
            },
            margins = 2,
            widget = wibox.container.margin,
          },
          {
            id = "text_role",
            widget = wibox.widget.textbox,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        -- left = 8,
        -- right = 8,
        margins = 8,
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
  s.mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
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

  -- Create the wibox
  s.mywibox = awful.wibar {
    screen = s,
    visible = true,
    ontop = false,
    type = "dock",
    -- width = dpi(48),
    -- width = s.geometry.width - beautiful.useless_gap * 5,
    shape = utils.shape.rrect(beautiful.border_radius / 2),
    -- bg = beautiful.bg_color,
    margins = beautiful.useless_gap,
  }

  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist,
      s.mypromptbox,
      spacer,
    },
    s.mytasklist,
    {
      layout = wibox.layout.fixed.horizontal,
      spacer,
      cpu,
      spacer,
      mem,
      wibox.widget.systray(),
      mykeyboardlayout,
      mytextclock,
      s.mylayoutbox,
    },
  }
end)

-- }}}
