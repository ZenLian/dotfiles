local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local hotkeys_popup = require("awful.hotkeys_popup")
local utils = require("zl.utils")
local service = require("zl.service")
local O = require("zl.configs").options

local modkey = "Mod4"
local ctrl = "Control"
local shift = "Shift"
local alt = "Mod1"

-- {{{ awesome awesomes!
awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, "F1", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ modkey, ctrl }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, ctrl }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "a", function()
    local screen = awful.screen.focused()
    require("zl.screen.controlCenter").toggle(screen)
  end, { description = "quit awesome", group = "awesome" }),
}
-- }}}

-- {{{ launchers
awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, "Return", function()
    awful.spawn(O.apps.terminal)
  end, { description = "terminal", group = "launcher" }),

  awful.key({ modkey }, "b", function()
    awful.spawn(O.apps.browser)
  end, { description = "web browser", group = "launcher" }),

  awful.key({ modkey }, "e", function()
    awful.spawn(O.apps.explorer)
  end, { description = "file explorer", group = "launcher" }),

  -- TODO: configurable
  awful.key({ modkey }, "p", function()
    awful.spawn(O.apps.launcher)
  end, { description = "rofi drun", group = "launcher" }),
  awful.key({ modkey }, "r", function()
    awful.spawn("rofi -show run")
  end, { description = "rofi run", group = "launcher" }),
  awful.key({ modkey }, "w", function()
    awful.spawn("rofi -show window")
  end, { description = "rofi window", group = "launcher" }),

  -- TODO: lauch colorpicker, screenshoter
}
-- }}}

-- {{{ wibar
awful.keyboard.append_client_keybindings {
  awful.key({ modkey }, "\\", function()
    awesome.emit_signal("zl::cal_show", { timeout = 5 })
  end),
}
-- }}}

-- media control(fn)
awful.keyboard.append_global_keybindings {
  awful.key({}, "XF86MonBrightnessUp", function()
    service.brightness.set("15%+")
  end, { description = "increase brightness", group = "control" }),

  awful.key({}, "XF86MonBrightnessDown", function()
    service.brightness.set("15%-")
  end, { description = "decrease brightness", group = "control" }),

  -- awful.key({}, "Print", function()
  -- 	awful.util.spawn(home_var .. "/.scripts/ss area", false)
  -- end, { description = "screenshot", group = "control" }),

  awful.key({}, "XF86AudioRaiseVolume", function()
    service.volume.set("5%+")
  end, { description = "increase volume", group = "control" }),

  awful.key({}, "XF86AudioLowerVolume", function()
    service.volume.set("5%-")
  end, { description = "decrease volume", group = "control" }),

  awful.key({}, "XF86AudioMute", function()
    service.volume.set("toggle")
  end, { description = "mute volume", group = "control" }),

  -- awful.key({ modkey }, "F2", function()
  -- 	misc.musicMenu()
  -- end, { description = "music menu", group = "control" }),
}

--- {{{ tags
awful.keyboard.append_global_keybindings {

  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
  awful.key({ modkey, ctrl }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ modkey, ctrl }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),

  -- view tag only
  awful.key {
    modifiers = { modkey },
    keygroup = awful.key.keygroup.NUMROW,
    description = "view tag only",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  },

  -- toggle tag display
  awful.key {
    modifiers = { modkey, ctrl },
    keygroup = awful.key.keygroup.NUMROW,
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  },

  -- Move client to tag.
  awful.key {
    modifiers = { modkey, shift },
    keygroup = awful.key.keygroup.NUMROW,
    description = "move focused client to tag #n",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
          tag:view_only()
        end
      end
    end,
  },

  -- Toggle tag on focused client.
  awful.key {
    modifiers = { modkey, ctrl, shift },
    keygroup = awful.key.keygroup.NUMROW,
    description = "toggle focused client on tag #n",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  },
}
-- }}}

-- {{{ focus
awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, { description = "go back", group = "client" }),

  -- focus by direction
  awful.key {
    modifiers = { modkey },
    keygroup = awful.key.keygroup.ARROWS,
    description = "focus by direction",
    group = "client",
    on_press = function(dir)
      awful.client.focus.bydirection(dir:lower())
    end,
  },

  -- focus by index
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next", group = "client" }),
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous", group = "client" }),

  -- focus screen
  awful.key({ modkey, ctrl }, "j", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, ctrl }, "k", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),

  -- focus urgent client
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),

  awful.key({ modkey, ctrl }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" }),
}
-- }}}

-- {{{ layout
awful.keyboard.append_global_keybindings {
  -- swap clients
  awful.key({ modkey, shift }, "n", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, shift }, "p", function()
    awful.client.swap.byidx(-1)
  end, { description = "swap with previous client by index", group = "client" }),

  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),

  awful.key({ modkey, shift }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, { description = "increase the number of master clients", group = "layout" }),
  awful.key({ modkey, shift }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, { description = "decrease the number of master clients", group = "layout" }),
  awful.key({ modkey, ctrl }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, { description = "increase the number of columns", group = "layout" }),
  awful.key({ modkey, ctrl }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, { description = "decrease the number of columns", group = "layout" }),
}

-- {{{ select layouts
awful.keygrabber {
  start_callback = function()
    awesome.emit_signal("zl::layout_visible", true)
    -- layout_popup.visible = true
  end,
  stop_callback = function()
    awesome.emit_signal("zl::layout_visible", false)
    -- layout_popup.visible = false
  end,
  export_keybindings = true,
  stop_event = "release",
  stop_key = modkey, --{ "Escape", "Super_L", "Super_R", modkey },
  keybindings = {
    awful.key {
      modifiers = { modkey, shift },
      key = "space",
      on_press = function()
        -- awful.layout.inc(-1)
        -- awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, -1), nil)
      end,
      description = "select previous layout",
      group = "layout",
    },
    awful.key {
      modifiers = { modkey },
      key = "space",
      on_press = function()
        -- awful.layout.inc(1)
        -- awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, 1), nil)
      end,
      description = "select next layout",
      group = "layout",
    },
  },
}

awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),
  awful.key({ modkey, "Shift" }, "space", function()
    awful.layout.inc(-1)
  end, { description = "select previous", group = "layout" }),
}
-- }}}
-- }}}

awful.mouse.append_global_mousebindings {
  -- awful.button({}, 3, function()
  -- 	mymainmenu:toggle()
  -- end),
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev),
}

local clientkeys = {
  awful.key({ modkey, shift }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),

  awful.key({ modkey }, "q", function(c)
    c:kill()
  end, { description = "quit", group = "client" }),

  awful.key({ modkey }, "f", function(c)
    awful.client.floating.toggle()
  end, { description = "toggle floating", group = "client" }),

  awful.key({ modkey, ctrl }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, { description = "move to master", group = "client" }),

  awful.key({ modkey }, "o", function(c)
    c:move_to_screen()
  end, { description = "move to screen", group = "client" }),

  awful.key({ modkey }, "t", function(c)
    c.ontop = not c.ontop
  end, { description = "toggle keep on top", group = "client" }),

  awful.key({ modkey }, "z", function(c)
    c.minimized = true
  end, { description = "minimize", group = "client" }),

  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "(un)maximize", group = "client" }),

  awful.key({ modkey, ctrl }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end, { description = "(un)maximize vertically", group = "client" }),
  awful.key({ modkey, shift }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end, { description = "(un)maximize horizontally", group = "client" }),
}

local clientbuttons = {
  awful.button({}, 1, function(c)
    c:activate { context = "mouse_click" }
  end),

  awful.button({ modkey }, 1, function(c)
    c:activate { context = "mouse_click", action = "mouse_move" }
  end),

  awful.button({ modkey }, 3, function(c)
    c:activate { context = "mouse_click", action = "mouse_resize" }
  end),
}

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings(clientkeys)
end)

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings(clientbuttons)
end)
