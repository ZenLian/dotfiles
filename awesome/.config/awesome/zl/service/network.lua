-- "service::network"
local service = require("zl.service.core")
local utils = require("zl.utils")

local M = {
  devices = {},
}

local listdev = function()
  local devices = {}
  local f = io.popen("ls -1 /sys/class/net")
  if f ~= nil then
    for device in f:lines() do
      devices[#devices + 1] = device
    end
    f:close()
  end
  return devices
end

M.get = function()
  local result = {}

  -- list devices
  for _, name in ipairs(listdev()) do
    local dev = {}
    local sysnet = "/sys/class/net/" .. name

    -- state
    dev.carrier = utils.io.first_line(string.format("%s/carrier", sysnet)) or "0"
    dev.state = utils.io.first_line(string.format("%s/operstate", sysnet)) or "down"

    -- total tx/rx bytes
    local tx = tonumber(utils.io.first_line(string.format("%s/statistics/tx_bytes", sysnet)) or 0)
    local rx = tonumber(utils.io.first_line(string.format("%s/statistics/rx_bytes", sysnet)) or 0)
    dev.tx, dev.rx = tx, rx

    -- calculate net speed
    local now = os.time()
    if not M.devices[name] then
      dev.up, dev.down = 0, 0
    else
      local interval = now - M.devices[name].time
      if interval <= 0 then
        interval = 1
      end
      local up = (tx - M.devices[name].tx) / interval
      local down = (rx - M.devices[name].rx) / interval

      dev.up = string.format("%.1f", up)
      dev.down = string.format("%.1f", down)
    end
    dev.time = now

    result[name] = dev
  end

  -- wifi
  for _, line in ipairs(utils.io.get_lines("/proc/net/wireless", 3)) do
    local name, level = string.match(line, "([%w]+):[%s]+[%d]+[%s]+[%d]+%.[%s]+(%-[%d]+)%.")
    -- level to signal: -100dBm=>0%, -50dBm=>100%
    local signal = 200 + tonumber(level) * 2
    result[name].wifi = {
      level = tonumber(level),
      signal = signal,
    }
  end

  M.devices = result
  return result
end

return service.register(M, "network", 5)
