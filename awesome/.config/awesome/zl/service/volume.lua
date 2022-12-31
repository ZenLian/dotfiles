-- volume signal
-- ("service::volume"), function({volume=int, muted=boolean}, src(string))

local awful = require("awful")
local gtimer = require("gears.timer")
local service = require("zl.service.core")

local M = {
  status = service.status.STOPPED,
  timeout = 5,
}

local vol_cmd = "amixer -D pulse get Master"

local parse = function(stdout)
  -- capture amixer output, e.g. [40%] [on]
  local volume, state = string.match(stdout, "%[([%d]+)%%%].*%[([%l]*)%]")
  return {
    volume = tonumber(volume),
    muted = state ~= "on",
  }
end

local emit_signal = function(src)
  awful.spawn.easy_async_with_shell(vol_cmd, function(stdout)
    local result = parse(stdout)
    awesome.emit_signal("service::volume", result, src)
    -- require("naughty").notify {
    --   text = string.format("%s %s", result.volume, result.muted),
    -- }
  end)
end

M.run = function()
  if M.status ~= service.status.STOPPED then
    return
  end
  M.status = service.status.STARTING

  gtimer {
    timeout = M.timeout,
    autostart = true,
    call_now = true,
    callback = function()
      emit_signal("timeout")
    end,
  }

  M.status = service.status.RUNNING
end

M.get = function(callback)
  awful.spawn.easy_async(vol_cmd, function(stdout)
    callback(parse(stdout))
  end)
end

M.set = function(val, src)
  if type(val) == "number" then
    awful.spawn.easy_async("amixer -D pulse set Master " .. val .. "%", function()
      emit_signal(src)
    end)
  else
    awful.spawn.easy_async("amixer -D pulse set Master " .. val, function()
      emit_signal(src)
    end)
  end
end

return M
