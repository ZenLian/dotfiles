local awful = require("awful")

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

-- Material Design Icons path
M.mdi = function(name)
  return os.getenv("HOME") .. "/.config/awesome/mods/mdi/svg/" .. name .. ".svg"
end

local PREFIX = ... .. "."

return setmetatable(M, {
  __index = function(self, key)
    local module = require(PREFIX .. key)
    rawset(self, key, module)
    return module
  end,
})
