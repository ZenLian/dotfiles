-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors,
	})
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		-- Make sure we don't go into an endless error loop
		if in_error then
			return
		end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = tostring(err),
		})
		in_error = false
	end)
end
-- }}}

require("zl").setup()

-- {{{ Variable definitions

-- This is used later as the default terminal and editor to run.
local terminal = "alacritty"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
local modkey = "Mod4"

-- {{{ Menu
-- Create a launcher widget and a main menu
-- local myawesomemenu = {
-- 	{
-- 		"hotkeys",
-- 		function()
-- 			hotkeys_popup.show_help(nil, awful.screen.focused())
-- 		end,
-- 	},
-- 	{ "manual", terminal .. " -e man awesome" },
-- 	{ "edit config", editor_cmd .. " " .. awesome.conffile },
-- 	{ "restart", awesome.restart },
-- 	{
-- 		"quit",
-- 		function()
-- 			awesome.quit()
-- 		end,
-- 	},
-- }
--
-- local mymainmenu = awful.menu({
-- 	items = {
-- 		{ "awesome", myawesomemenu, beautiful.awesome_icon },
-- 		{ "open terminal", terminal },
-- 	},
-- })
--
-- local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Menubar configuration
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
--local mykeyboardlayout = awful.widget.keyboardlayout()
