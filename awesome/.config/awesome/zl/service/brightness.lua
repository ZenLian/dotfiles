-- brightness signal
-- "service::brightness"
-- percentage, src(string)
local awful = require("awful")
local gtimer = require("gears.timer")
local service = require("zl.service.core")

local M = {
  status = service.status.STOPPED,
}

local brightness_cmd = "brightnessctl info"

local parse = function(stdout)
  local percentage = string.match(stdout, "%(([%d]+)%%%)")
  return { percentage = tonumber(percentage) }
end

local emit_signal = function(src)
  awful.spawn.easy_async_with_shell(brightness_cmd, function(stdout)
    local result = parse(stdout)
    awesome.emit_signal("service::brightness", result, src)
  end)
end

M.run = function()
  if M.status ~= service.status.STOPPED then
    return
  end
  M.status = service.status.STARTING

  -- emit once at start
  emit_signal("init")

  -- gtimer {
  --   timeout = M.timeout,
  --   autostart = true,
  --   call_now = true,
  --   callback = function()
  --     emit_signal("timeout")
  --   end,
  -- }

  M.status = service.status.RUNNING
end

M.get = function(callback)
  awful.spawn.easy_async_with_shell(brightness_cmd, function(stdout)
    local result = parse(stdout)
    callback(result)
  end)
end

M.set = function(val, src)
  if type(val) == "number" then
    awful.spawn.easy_async("brightnessctl set " .. val .. "% -q", function()
      emit_signal(src)
    end)
  else
    awful.spawn.easy_async("brightnessctl set " .. val .. " -q", function()
      emit_signal(src)
    end)
  end
end

return M
