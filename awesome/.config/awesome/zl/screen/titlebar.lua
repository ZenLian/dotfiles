local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function create_button(args) --{color, action, c}
  -- the widget
  local w = wibox.widget {
    widget = wibox.container.background,
    bg = beautiful.titlebar_button_bg,
    shape = gears.shape.circle, -- utils.shape.prrect(beautiful.border_radius, true, true, false, true),
    forced_width = beautiful.titlebar_button_size,
    forced_height = beautiful.titlebar_button_size,
  }
  w.main_color = args.color

  -- hover effect
  w:connect_signal("mouse::enter", function()
    w.bg = w.main_color .. "99"
  end)

  w:connect_signal("mouse::leave", function()
    w.bg = w.main_color
  end)

  -- press effect
  -- w:connect_signal("button::press", function()
  --   w.bg = w.main_color .. "99"
  -- end)
  --
  -- w:connect_signal("button::release", function()
  --   w.bg = w.main_color .. "55"
  -- end)

  -- focus color
  local function on_focus_changed(c)
    if client.focus == c then
      w.bg = w.main_color
    else
      w.bg = beautiful.titlebar_button_bg
    end
  end

  -- apply dynamic color
  args.client:connect_signal("focus", on_focus_changed)

  args.client:connect_signal("unfocus", on_focus_changed)

  -- button action
  w:buttons(gears.table.join(awful.button({}, 1, args.action)))

  return w
end

-- Add a titlebar
client.connect_signal("request::titlebars", function(c)
  -- move/resize action for the bar
  local buttons = {
    awful.button({}, 1, function()
      c:activate { context = "titlebar", action = "mouse_move" }
    end),
    awful.button({}, 3, function()
      c:activate { context = "titlebar", action = "mouse_resize" }
    end),
  }

  local titlebar = awful.titlebar(c, {
    position = "top",
    size = beautiful.titlebar_size,
    -- font =,
    -- fg =,
    -- bg =
  })

  titlebar:setup {
    layout = wibox.layout.align.horizontal,
    -- {
    --   markup = string.format("%s | %s | %s", c.class, c.role, c.instance),
    --   widget = wibox.widget.textbox,
    -- },
    nil,
    {
      wibox.widget.textbox,
      layout = wibox.layout.flex.horizontal,
      buttons = buttons,
    },
    {
      {
        create_button {
          color = beautiful.titlebar_minimize_button_bg,
          action = function()
            awful.client.floating.toggle(c)
          end,
          client = c,
        },
        create_button {
          color = beautiful.titlebar_maximize_button_bg,
          action = function()
            c.maximized = not c.maximized
            c:raise()
          end,
          client = c,
        },
        create_button {
          color = beautiful.titlebar_close_button_bg,
          action = function()
            c:kill()
          end,
          client = c,
        },
        layout = wibox.layout.flex.horizontal,
        spacing = beautiful.titlebar_button_margin,
      },
      widget = wibox.container.margin,
      margins = { right = beautiful.titlebar_button_margin },
    },
    -- {
    --   {
    --     layout = wibox.layout.align.vertical,
    --     expand = "none",
    --   },
    --   margins = { right = dpi(24) },
    --   widget = wibox.container.margin,
    -- },

    -- { -- Left
    --   awful.titlebar.widget.iconwidget(c),
    --   buttons = buttons,
    --   layout = wibox.layout.fixed.horizontal,
    -- },
    -- { -- Middle
    --   { -- Title
    --     align = "center",
    --     widget = awful.titlebar.widget.titlewidget(c),
    --   },
    --   buttons = buttons,
    --   layout = wibox.layout.flex.horizontal,
    -- },
    -- { -- Right
    --   awful.titlebar.widget.floatingbutton(c),
    --   awful.titlebar.widget.maximizedbutton(c),
    --   awful.titlebar.widget.stickybutton(c),
    --   awful.titlebar.widget.ontopbutton(c),
    --   awful.titlebar.widget.closebutton(c),
    --   layout = wibox.layout.fixed.horizontal(),
    -- },
  }
end)
