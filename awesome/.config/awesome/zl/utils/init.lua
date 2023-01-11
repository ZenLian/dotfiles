local awful = require("awful")
local naughty = require("naughty")

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

function M.font(size)
  local config = require("zl.config")
  size = size or config.theme.font.family
  return string.format("%s %d", config.theme.font.family, size)
end

function M.icon_font(size)
  local config = require("zl.config")
  size = size or config.theme.icon_font.family
  return string.format("%s %d", config.theme.icon_font.family, size)
end

M.debug = function(text, args)
  local opts = {
    urgency = "low",
    title = "<span><b>Debug</b></span>",
    text = text,
    timeout = 0,
    -- fg = theme.color.custom.blue,
    -- bg = theme.color.
    -- border_color = ,
  }
  opts = M.table.extend(opts, args)
  naughty.notification(opts)
end

M.error = function(text, args)
  local opts = {
    urgency = "critical",
    text = text,
  }
  opts = M.table.extend(opts, args)
  naughty.notification(opts)
end

local PREFIX = ... .. "."

return setmetatable(M, {
  __index = function(self, key)
    local module = require(PREFIX .. key)
    rawset(self, key, module)
    return module
  end,
})
