local M = {}

local beautiful = require("beautiful")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gears = require("gears")
local sys_themes_path = require("gears.filesystem").get_themes_dir()
local theme_path = os.getenv("HOME") .. "/.config/awesome/zl/theme"

M.options = {
	flavour = "mocha",
	--font = "JetBrainsMono Nerd Font 10"
	font = {
		family = "Caskaydia Cove Nerd Font",
		size = 12,
	},
	taglist = {
		square = false,
	},
	border_width = 5,
	border_radius = 10,
	gap = 5,
}

function M.setup(opt)
	-- TODO: merge configs to M.options
	local O = gears.table.merge(M.options, opt or {})
	local C = require("zl.theme.palettes").get(O.flavour)

	local theme = {}

	-- {{{ Theme variables
	-- https://awesomewm.org/apidoc/theme_related_libraries/beautiful.html#Theme_variables
	theme.font = O.font.family .. " " .. O.font.size
	theme.wallpaper = theme_path .. "/wallpapers/unicat.png"
	theme.icon_theme = "/usr/share/icons/breeze"

	-- base colors
	theme.bg_normal = C.mantle
	theme.bg_focus = C.surface0
	theme.bg_urgent = C.base
	theme.bg_minimize = C.mantle
	theme.bg_systray = C.mantle
	theme.fg_normal = C.text
	theme.fg_focus = C.blue
	theme.fg_urgent = C.red
	theme.fg_minimize = C.surface2
	-- }}}

	-- {{{ gap/border
	theme.useless_gap = dpi(O.gap)
	theme.border_width = dpi(O.border_width)
	theme.border_normal = theme.bg_normal
	theme.border_focus = C.blue
	theme.border_marked = C.mauve
	-- }}}

	--------------------
	-- {{{ notifications
	--------------------
	-- Variables set for theming notifications:
	-- notification_font
	-- notification_[bg|fg]
	-- notification_[width|height|margin]
	-- notification_[border_color|border_width|shape|opacity]
	theme.notification_font = O.font.family .. " 12"
	theme.notification_margin = dpi(10) -- TODO: options
	theme.notification_border_color = C.green
	theme.notification_border_width = dpi(O.border_width)
	theme.notification_border_radius = dpi(O.border_radius)
	theme.notification_icon_size = dpi(60) -- TODO: what is this?
	-- }}}

	---------------
	-- {{{ titlebar
	---------------
	-- titlebar_[bg|fg]_[normal|focus]
	theme.titlebar_bg_normal = theme.bg_normal
	theme.titlebar_bg_focus = theme.bg_normal
	theme.titlebars_enabled = true

	-- You can add as many variables as
	-- you wish and access them by using
	-- beautiful.variable in your rc.lua
	-- Define the image to load
	theme.titlebar_close_button_normal = sys_themes_path .. "default/titlebar/close_normal.png"
	theme.titlebar_close_button_focus = sys_themes_path .. "default/titlebar/close_focus.png"

	theme.titlebar_minimize_button_normal = sys_themes_path .. "default/titlebar/minimize_normal.png"
	theme.titlebar_minimize_button_focus = sys_themes_path .. "default/titlebar/minimize_focus.png"

	theme.titlebar_ontop_button_normal_inactive = sys_themes_path .. "default/titlebar/ontop_normal_inactive.png"
	theme.titlebar_ontop_button_focus_inactive = sys_themes_path .. "default/titlebar/ontop_focus_inactive.png"
	theme.titlebar_ontop_button_normal_active = sys_themes_path .. "default/titlebar/ontop_normal_active.png"
	theme.titlebar_ontop_button_focus_active = sys_themes_path .. "default/titlebar/ontop_focus_active.png"

	theme.titlebar_sticky_button_normal_inactive = sys_themes_path .. "default/titlebar/sticky_normal_inactive.png"
	theme.titlebar_sticky_button_focus_inactive = sys_themes_path .. "default/titlebar/sticky_focus_inactive.png"
	theme.titlebar_sticky_button_normal_active = sys_themes_path .. "default/titlebar/sticky_normal_active.png"
	theme.titlebar_sticky_button_focus_active = sys_themes_path .. "default/titlebar/sticky_focus_active.png"

	theme.titlebar_floating_button_normal_inactive = sys_themes_path .. "default/titlebar/floating_normal_inactive.png"
	theme.titlebar_floating_button_focus_inactive = sys_themes_path .. "default/titlebar/floating_focus_inactive.png"
	theme.titlebar_floating_button_normal_active = sys_themes_path .. "default/titlebar/floating_normal_active.png"
	theme.titlebar_floating_button_focus_active = sys_themes_path .. "default/titlebar/floating_focus_active.png"

	theme.titlebar_maximized_button_normal_inactive = sys_themes_path
		.. "default/titlebar/maximized_normal_inactive.png"
	theme.titlebar_maximized_button_focus_inactive = sys_themes_path .. "default/titlebar/maximized_focus_inactive.png"
	theme.titlebar_maximized_button_normal_active = sys_themes_path .. "default/titlebar/maximized_normal_active.png"
	theme.titlebar_maximized_button_focus_active = sys_themes_path .. "default/titlebar/maximized_focus_active.png"
	-- }}}

	-- {{{ taglist
	----------------
	-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
	theme.taglist_bg_focus = theme.bg_focus
	theme.taglist_fg_focus = theme.fg_focus
	theme.taglist_bg_urgent = theme.bg_urgent
	theme.taglist_fg_urgent = theme.fg_urgent
	theme.taglist_bg_occupied = theme.bg_normal
	theme.taglist_fg_occupied = theme.fg_normal
	theme.taglist_bg_empty = theme.bg_normal
	theme.taglist_fg_empty = C.surface2
	-- custom
	theme.taglist_bg_hover = theme.taglist_bg_focus .. "dd"

	-- Generate taglist squares:
	if O.taglist.square then
		local taglist_square_size = dpi(10)
		theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
		theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)
	end
	theme.taglist_disable_icon = true

	-- }}}

	-- {{{ tasklist
	-----------------
	-- tasklist_[bg|fg]_[focus|urgent]
	-- theme.tasklist_bg_minimize = C.mantle
	-- theme.tasklist_bg_normal = C.base
	-- theme.tasklist_bg_focus = C.surface0
	theme.tasklist_font = O.font.family .. " 11"
	theme.tasklist_plain_task_name = true
	-- }}}

	-- {{{ layout icons
	---------------------
	-- theme.layout_floating = gears.color.recolor_image(theme_path .. "layouts/floatingw.png", theme.fg_normal)
	-- theme.layout_tile = gears.color.recolor_image(theme_path .. "layouts/tilew.png", theme.fg_normal)
	-- theme.layout_fairh = gears.color.recolor_image(theme_path .. "layouts/fairhw.png", theme.fg_normal)
	-- theme.layout_fairv = gears.color.recolor_image(theme_path .. "layouts/fairvw.png", theme.fg_normal)
	-- theme.layout_spiral = gears.color.recolor_image(theme_path .. "layouts/spiralw.png", theme.fg_normal)
	-- TODO: what's this
	-- theme.layout_machi = gears.color.recolor_image(theme.images.layouts.layoutMachi, theme.fg_normal)
	theme.layout_floating = sys_themes_path .. "default/layouts/floatingw.png"
	theme.layout_tile = sys_themes_path .. "default/layouts/tilew.png"
	theme.layout_fairh = sys_themes_path .. "default/layouts/fairhw.png"
	theme.layout_fairv = sys_themes_path .. "default/layouts/fairvw.png"
	theme.layout_spiral = sys_themes_path .. "default/layouts/spiralw.png"

	-- not in use
	theme.layout_magnifier = sys_themes_path .. "default/layouts/magnifierw.png"
	theme.layout_max = sys_themes_path .. "default/layouts/maxw.png"
	theme.layout_fullscreen = sys_themes_path .. "default/layouts/fullscreenw.png"
	theme.layout_tilebottom = sys_themes_path .. "default/layouts/tilebottomw.png"
	theme.layout_tileleft = sys_themes_path .. "default/layouts/tileleftw.png"
	theme.layout_tiletop = sys_themes_path .. "default/layouts/tiletopw.png"
	theme.layout_dwindle = sys_themes_path .. "default/layouts/dwindlew.png"
	theme.layout_cornernw = sys_themes_path .. "default/layouts/cornernww.png"
	theme.layout_cornerne = sys_themes_path .. "default/layouts/cornernew.png"
	theme.layout_cornersw = sys_themes_path .. "default/layouts/cornersww.png"
	theme.layout_cornerse = sys_themes_path .. "default/layouts/cornersew.png"
	--- }}}

	-- drop-down menu {{{
	-- menu_[bg|fg]_[normal|focus]
	-- menu_[border_color|border_width]
	theme.menu_font = O.font.family .. " 10"
	theme.menu_submenu_icon = sys_themes_path .. "default/submenu.png"
	theme.menu_height = dpi(25)
	theme.menu_width = dpi(150)
	theme.menu_border_radius = 200
	theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_normal, theme.fg_focus)
	-- }}}

	---------------------
	-- hotkyes popup {{{1
	---------------------
	-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
	-- theme.hotkeys_shape = helpers.rrect(theme.rounded)
	theme.hotkeys_border_width = 0
	theme.hotkeys_font = O.font.family .. " 11"
	theme.hotkeys_group_margin = 30
	theme.hotkeys_label_bg = C.rosewater
	theme.hotkeys_label_fg = C.base
	theme.hotkeys_description_font = O.font.family .. " 8"
	theme.hotkeys_modifiers_fg = theme.fg_normal .. "33"
	theme.hotkeys_bg = C.base

	----------------
	-- Tooltips {{{1
	----------------
	-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
	-- theme.tooltip_bg = theme.bg_normal
	-- theme.tooltip_fg = theme.fg_normal
	theme.tooltip_border_width = 0
	theme.tooltip_align = "top"
	theme.tooltip_margin = "top"

	-- There are other variable sets
	-- overriding the default one when
	-- defined, the sets are:
	-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
	-- prompt_[fg|bg|fg_cursor|bg_cursor|font]

	-- You can add as many variables as
	-- you wish and access them by using
	-- beautiful.variable in your rc.lua

	-- init theme, or fallback to default
	if not beautiful.init(theme) then
		beautiful.init(sys_themes_path .. "/default/theme.lua")
	end
end
return M

--vim:foldmethod=marker:foldmarker={{{,}}}:
