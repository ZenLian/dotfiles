local gears = { timer = require("gears.timer") }
local naughty = require("naughty")

local M = {
  status = {
    STOPPED = "stopped",
    STARTING = "starting",
    RUNNING = "running",
  },
}

M.run = function()
  require("zl.service.volume").run()
  require("zl.service.brightness").run()
  require("zl.service.cpu").run()
end

local run = function(serv)
  if serv.status ~= M.status.STOPPED then
    return
  end
  serv.status = M.status.STARTING

  if serv.timeout > 0 then
    gears.timer {
      timeout = serv.timeout,
      autostart = true,
      call_now = true,
      callback = function()
        serv.update("timeout")
      end,
    }
  else
    serv.update("init")
  end

  serv.status = M.status.RUNNING
end

M.register = function(serv, name, timeout)
  serv.name = "service::" .. name
  serv.timeout = timeout or 0
  serv.status = M.status.STOPPED
  serv.run = function()
    run(serv)
  end
  if serv.get_async then
    serv.update = function(src)
      serv.get_async(function(result)
        awesome.emit_signal(serv.name, result, src)
      end)
    end
  elseif serv.get then
    serv.update = function(src)
      awesome.emit_signal(serv.name, serv.get(), src)
    end
  else
    naughty.notify {
      preset = naughty.config.presets.warn,
      title = serv.name,
      text = "missing get_async() or get()",
    }
  end

  -- return setmetatable(serv, { __index = service })
  return serv
end

return M
