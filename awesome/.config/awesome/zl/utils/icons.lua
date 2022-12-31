local M = {}

M.volume = function(muted)
  return muted and "婢" or "墳"
end

local battery_icons = { "", "", "", "", "", "", "", "", "", "", "" }
local battery_charging_icons = { "", "", "", "", "", "", "", "", "", "", "" }

M.battery = function(perc, charging)
  local icons = charging and battery_charging_icons or battery_icons
  if perc < 0 then
    perc = 0
  end
  if perc > 100 then
    perc = 100
  end
  return icons[perc // 10 + 1]
end

return M
