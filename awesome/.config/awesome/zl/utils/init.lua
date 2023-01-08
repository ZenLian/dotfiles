local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

local M = {}

-- run a command once, do nothing if another instance is running
M.run_once = function(command)
  local name = command
  local pos = command:find(" ")
  if pos then
    name = command:sub(0, pos - 1)
  end

  awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", name, command))
end

M.debug = function(text, args)
  local opts = {
    title = "<span><b>Debug</b></span>",
    text = text,
    timeout = 0,
    fg = beautiful.palette.blue,
    bg = beautiful.palette.base,
    border_color = beautiful.palette.blue,
  }
  opts = M.table.extend(opts, args)
  naughty.notify(opts)
end

M.error = function(text)
  naughty.notify {
    title = "<b>Error</b>",
    text = text,
    timeout = 0,
    fg = beautiful.palette.red,
    bg = beautiful.palette.base,
    border_color = beautiful.palette.red,
  }
end

local PREFIX = ... .. "."

return setmetatable(M, {
  __index = function(self, key)
    local module = require(PREFIX .. key)
    rawset(self, key, module)
    return module
  end,
})
