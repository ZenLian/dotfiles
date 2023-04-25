local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local utils = require("utils")
local theme_path = os.getenv("HOME") .. "/.config/awesome/theme"
local p = require("theme.palette")
local icons = require("theme.icons")

local function init()
  local O = require("config").theme
  local theme = {}

  --------------------------------------
  -- fonts, icons and wallpapers
  --------------------------------------
  theme.font = O.font.family .. " " .. O.font.size
  theme.wallpaper = theme_path .. "/wallpapers/LockScreen/arch-rainbow-1920x1080.png"
  theme.icon_theme = O.icon_theme
  theme.awesome_icon = theme_path .. "/icons/awesome.svg"

  --------------------------------------
  -- common colors
  --------------------------------------
  theme.bg_normal = p.base
  theme.fg_normal = p.text
  theme.bg_focus = p.surface0
  theme.fg_focus = p.blue
  theme.bg_urgent = p.red
  theme.fg_urgent = p.base
  theme.bg_minimize = p.base
  theme.fg_minimize = p.text

  --------------------------------------
  -- border
  --------------------------------------
  theme.border_color_maximized = p.base
  theme.border_color_normal = p.surface2 .. "80"
  theme.border_color_active = p.blue
  theme.border_color_marked = p.mauve
  theme.useless_gap = dpi(5)
  theme.border_width = dpi(2)
  theme.border_width_maximized = 0
  -- custom
  theme.border_radius = dpi(10) -- not builtin

  --------------------------------------
  -- notifications
  --------------------------------------
  theme.notification_fg = p.text
  theme.notification_bg = p.base
  theme.notification_border_color = p.surface
  theme.notification_font = utils.font()
  theme.notification_border_width = 0
  theme.notification_shape = gears.shape.rounded_rect
  theme.notification_opacity = 0.9
  theme.notification_margin = dpi(10)
  theme.notification_width = dpi(420)
  -- theme.notification_height = dpi(200)
  theme.notification_spacing = dpi(10)
  -- }}}

  --------------------------------------
  -- {{{ titlebar
  --------------------------------------
  -- titlebar_[bg|fg]_[normal|focus]
  theme.titlebar_bg_normal = p.base
  theme.titlebar_bg_focus = p.base
  theme.titlebars_enabled = true
  -- }}}

  --------------------------------------
  -- layout icons
  --------------------------------------
  theme.layout_floating = gears.color.recolor_image(theme_path .. "/icons/layouts/floating.svg", theme.fg_normal)
  theme.layout_dwindle = gears.color.recolor_image(theme_path .. "/icons/layouts/dwindle.svg", theme.fg_normal)
  theme.layout_tile = gears.color.recolor_image(theme_path .. "/icons/layouts/tile.svg", theme.fg_normal)
  theme.layout_max = gears.color.recolor_image(theme_path .. "/icons/layouts/max.svg", theme.fg_normal)
  theme.layout_fullscreen = gears.color.recolor_image(theme_path .. "/icons/layouts/fullscreen.svg", theme.fg_normal)

  -- drop-down menu {{{
  theme.menu_bg = p.surface
  theme.menu_fg = theme.fg_normal
  theme.menu_font = O.font.family .. " 10"
  theme.menu_submenu_icon = theme_path .. "/icons/chevron-right.svg"
  theme.menu_height = dpi(25)
  theme.menu_width = dpi(150)
  theme.menu_border_width = 0
  -- }}}

  --------------------------------------
  -- hotkyes popup
  --------------------------------------
  -- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
  theme.hotkeys_shape = utils.shape.rrect(theme.border_radius)
  theme.hotkeys_border_width = 0
  -- theme.hotkeys_border_color = C.blue
  theme.hotkeys_font = O.font.family .. " 11"
  theme.hotkeys_group_margin = 30
  -- theme.hotkeys_label_bg = p.rosewater
  -- theme.hotkeys_label_fg = p.base
  theme.hotkeys_description_font = O.font.family .. " 11"
  theme.hotkeys_description_fg = theme.fg_normal .. "ee"
  theme.hotkeys_modifiers_fg = theme.fg_normal .. "88"
  theme.hotkeys_bg = p.background

  --------------------------------------
  -- Tooltip
  --------------------------------------
  theme.tooltip_bg = p.surface0
  theme.tooltip_fg = p.text
  theme.tooltip_opacity = 0.95
  theme.tooltip_border_width = 0
  theme.tooltip_align = "top"
  theme.tooltip_margin = "top"

  --------------------------------------
  -- Taglist
  --------------------------------------
  theme.taglist_bg_focus = p.base
  theme.taglist_fg_focus = p.blue
  theme.taglist_bg_urgent = p.red
  theme.taglist_fg_urgent = p.base
  theme.taglist_bg_occupied = p.base
  theme.taglist_fg_occupied = p.text
  theme.taglist_bg_empty = p.base
  theme.taglist_fg_empty = p.overlay0

  --------------------------------------
  -- Systray
  --------------------------------------
  theme.bg_systray = p.base
  theme.systray_max_rows = 1
  theme.systray_icon_spacing = dpi(5)

  --------------------------------------
  -- Tasklist
  --------------------------------------
  -- theme.tasklist_bg_minimize = C.mantle
  -- theme.tasklist_bg_normal = C.base
  -- theme.tasklist_bg_focus = C.surface0
  theme.tasklist_fg_minimize = p.overlay0
  theme.tasklist_font = O.font.family .. " 11"
  -- theme.tasklist_disable_task_name = true
  -- theme.tasklist_disable_icon = true
  theme.tasklist_plain_task_name = true

  -- init theme, or fallback to default
  if not beautiful.init(theme) then
    local sys_themes_dir = gears.filesystem.get_themes_dir()
    beautiful.init(sys_themes_dir .. "/default/theme.lua")
  end
end

return {
  init = init,
}
