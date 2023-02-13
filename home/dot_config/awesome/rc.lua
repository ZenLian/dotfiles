pcall(require, "luarocks.loader")
local naughty = require("naughty")

-- {{{ mods path
local cfg_path = require("gears").filesystem.get_configuration_dir()
package.path = cfg_path .. "mods/?.lua;" .. cfg_path .. "mods/?/init.lua;" .. package.path
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message,
  }
end)
-- }}}

require("zl").setup {}
