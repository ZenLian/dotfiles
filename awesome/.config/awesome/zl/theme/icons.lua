local gears = require("gears")
local beautiful = require("beautiful")

local icons = {
  -- widgets
  cpu = "",
  memory = "",
  thermal = "﨏", -- "",
  wifi = "直",
  battery = "",
  battery_charging = { "", "", "", "", "", "", "", "", "", "", "" },
  battery_discharging = { "", "", "", "", "", "", "", "", "", "", "" },
  volume = "墳",
  volume_muted = "婢",
  brightness = "", --"󰃟", -- ""

  -- apps
  web = "",
  files = "",
}

icons.get_battery = function(perc, charging)
  if not perc then
    return icons.battery
  end
  local bat = charging and icons.battery_charging or icons.battery_discharging
  perc = math.min(100, math.max(perc, 0))
  return bat[perc // 10 + 1]
end

icons.get_volume = function(muted)
  return muted and icons.volume_muted or icons.volume
end

-- get Material Design Icon SVG image
local MDI_ICON_PATH = gears.filesystem.get_configuration_dir() .. "mods/mdi/svg/%s.svg"
icons.get_mdi = function(name, color)
  local icon_path = MDI_ICON_PATH:format(name)
  return gears.color.recolor_image(icon_path, color or beautiful.fg_normal)
end

icons.get_mdi_wifi = function(level, fg)
  if level < -83 then
    return icons.get_mdi("wifi-strength-1", fg)
  elseif level < -70 then
    return icons.get_mdi("wifi-strength-2", fg)
  elseif level < -54 then
    return icons.get_mdi("wifi-strength-3", fg)
  else
    return icons.get_mdi("wifi-strength-4", fg)
  end
end

return icons
