-- volume signal
-- ("service::volume"), function({volume=int, muted=boolean}, src(string))

local awful = require("awful")
local gtimer = require("gears.timer")
local service = require("zl.service.core")

local M = {}

local vol_cmd = "amixer -D pulse get Master"

local parse = function(stdout)
  -- capture amixer output, e.g. [40%] [on]
  local volume, state = string.match(stdout, "%[([%d]+)%%%].*%[([%l]*)%]")
  return {
    volume = tonumber(volume),
    muted = state ~= "on",
  }
end

-- M.async = function(callback)
--   awful.spawn.easy_async_with_shell(vol_cmd, function(stdout)
--     local result = parse(stdout)
--     callback(result)
--   end)
-- end

M.get_async = function(callback)
  awful.spawn.easy_async(vol_cmd, function(stdout)
    callback(parse(stdout))
  end)
end

M.set = function(val, src)
  if type(val) == "number" then
    awful.spawn.easy_async("amixer -D pulse set Master " .. val .. "%", function()
      M.update(src)
    end)
  else
    awful.spawn.easy_async("amixer -D pulse set Master " .. val, function()
      M.update(src)
    end)
  end
end

return service.register(M, "volume", 7)