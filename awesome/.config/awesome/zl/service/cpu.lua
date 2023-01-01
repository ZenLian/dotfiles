-- brightness signal
-- "service::brightness"
-- percentage, src(string)
local awful = require("awful")
local gtimer = require("gears.timer")
local service = require("zl.service.core")

local M = {}

local last_total = 0
local last_active = 0
local cpu_usage = 0

local parse_cpu_line = function(line)
  local total = 0
  local idle_new = 0

  -- Calculate totals/idles
  local i = 1
  for v in string.gmatch(line, "[%s]+([^%s]+)") do
    -- 4 = idle, 5 = ioWait.
    if i == 4 or i == 5 then
      idle_new = idle_new + v
    end
    total = total + v
    i = i + 1
  end

  local active = total - idle_new

  -- Calculate percentage
  local diff_total = total - last_total
  local diff_active = active - last_active

  if diff_total == 0 then
    diff_total = 1E-6
  end
  cpu_usage = math.ceil((diff_active / diff_total) * 100)

  -- Store last
  last_total = total
  last_active = active

  return { usage = cpu_usage }
end

M.get = function()
  for line in io.lines("/proc/stat") do
    -- we only read first line for total cpu usage
    local result = parse_cpu_line(line)
    return result
  end
end

return service.register(M, "cpu", 6)
