local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local ruled = require("ruled")
local dpi = require("beautiful.xresources").apply_dpi
local p = require("theme.palette")

local M = {
  _enabled = false,
}

local styles = {
  container = {
    height = dpi(32),
  },
  button = {
    width = dpi(14),
    height = dpi(14),
    margin = dpi(14),
    bg = p.surface1,
  },
  minimize_button = {
    bg = p.yellow,
  },
  maximize_button = {
    bg = p.green,
  },
  close_button = {
    bg = p.red,
  },
}

local function create_button(args) --{color, action, c}
  -- the widget
  local w = wibox.widget {
    widget = wibox.container.background,
    bg = styles.button.bg,
    shape = gears.shape.circle,
    forced_width = styles.button.width,
    forced_height = styles.button.height,
  }
  w.main_color = args.color

  -- hover effect
  w:connect_signal("mouse::enter", function()
    w.bg = w.main_color
  end)

  w:connect_signal("mouse::leave", function()
    w.bg = styles.button.bg
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
  -- local function on_focus_changed(c)
  --   if client.focus == c then
  --     w.bg = w.main_color
  --   else
  --     w.bg =
  --   end
  -- end

  -- apply dynamic color
  -- args.client:connect_signal("focus", on_focus_changed)
  -- args.client:connect_signal("unfocus", on_focus_changed)

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
    size = styles.container.height,
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
          color = styles.minimize_button.bg,
          action = function()
            awful.client.floating.toggle(c)
          end,
          client = c,
        },
        create_button {
          color = styles.maximize_button.bg,
          action = function()
            c.maximized = not c.maximized
            c:raise()
          end,
          client = c,
        },
        create_button {
          color = styles.close_button.bg,
          action = function()
            c:kill()
          end,
          client = c,
        },
        layout = wibox.layout.flex.horizontal,
        spacing = styles.button.margin,
      },
      widget = wibox.container.margin,
      margins = { right = styles.button.margin },
    },
  }
end)

-- always add titlebars to dialog
ruled.client.append_rule {
  id = "titlebars_always",
  rule_any = { type = { "dialog" } },
  properties = { titlebars_enabled = true },
}

-- Add toggleable titlebars to normal clients
ruled.client.append_rule {
  id = "titlebars",
  rule_any = { type = { "normal" } },
  properties = { titlebars_enabled = M._enabled },
}

M.toggle = function()
  M._enabled = not M._enabled
  local toggle = M._enabled and awful.titlebar.show or awful.titlebar.hide
  for _, c in ipairs(client.get()) do
    toggle(c)
  end

  ruled.client.remove_rule("titlebars")
  ruled.client.append_rule {
    id = "titlebars",
    rule_any = { type = { "normal" } },
    properties = { titlebars_enabled = M._enabled },
  }
end

return M
