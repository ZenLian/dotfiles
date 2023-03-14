-- "service::disk"
local awful = require("awful")
local service = require("service.core")

local M = {}

local cache = {
  capslock = "off",
}

local xset_cmd = "xset q"

local parse = function(stdout)
  local result = {}
  result.capslock = string.match(stdout, "Caps Lock:[%s]+([%a]+)")
  -- require("naughty.notification") {
  --   text = result.capslock,
  -- }
  return result
end

M.init = function()
  M.get_async(function(result)
    cache = result
  end)
end

M.get_async = function(callback)
  awful.spawn.easy_async_with_shell(xset_cmd, function(stdout)
    local result = parse(stdout)
    callback(result)
  end)
end

-- override service update
M.update = function(src)
  M.get_async(function(result)
    if cache.capslock ~= result.capslock then
      cache.capslock = result.capslock
      awesome.emit_signal(M.name, result, src)
    end
  end)
end

return service.register(M, "xset", 0.15)
