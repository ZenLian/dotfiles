local wibox = require("wibox")
local awful = require("awful")
local menubar = require("menubar")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local tasklist_buttons = {
  awful.button({}, 1, function(c)
    c:activate { context = "tasklist", action = "toggle_minimization" }
  end),
  awful.button({}, 2, function(c)
    c:kill()
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
}

local taskicon_map = {
  ["lxrandr"] = "randr",
  ["arandr"] = "randr",
}

local tasklist_create = function(self, c)
  local imagebox = self:get_children_by_id("clienticon")[1]
  local candidates = {
    c.class,
    c.class:lower(),
    "applications-all",
  }
  local predefined = taskicon_map[c.class:lower()]
  if predefined then
    table.insert(candidates, 1, predefined)
  end
  local path
  for _, v in ipairs(candidates) do
    path = menubar.utils.lookup_icon(v)
    if path then
      break
    end
  end
  imagebox.image = path
end

local tasklist = function(s)
  return awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    layout = {
      spacing = dpi(3),
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        {
          id = "clienticon",
          widget = wibox.widget.imagebox,
        },
        margins = dpi(3),
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
      create_callback = tasklist_create,
      -- update_callback = tasklist_update,
    },
    buttons = tasklist_buttons,
  }
end

return tasklist
