local gears = require("gears")
local beautiful = require("beautiful")

-- https://pictogrammers.github.io/@mdi/font/6.9.96/
local icons = {
  -- widgets
  cpu = "󰻠", --"",
  memory = "󰍛",
  thermal = "󰔐",
  volume = "󰕾",
  volume_off = "󰖁",
  volume_mute = "󰝟",
  -- volumes = { "󰕿", "󰖀", "󰕾" },
  brightness = "󰃟", --"󰃟", -- ""
  wifi = "󰤨",
  wifi_off = "󰤭",
  wifi_strength = { "󰤟", "󰤢", "󰤥", "󰤨" },

  bluetooth = "󰂯",
  bluetooth_off = "󰂲",
  bluetooth_audio = "󰂰",
  bluetooth_connect = "󰂱",

  battery = "󰁹",
  battery_charging = { "󰢟", "󰢜", "󰂆", "󰂇", "󰂈", "󰢝", "󰂉", "󰢞", "󰂊", "󰂋", "󰂅" },
  battery_discharging = { "󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "" },

  switch_on = "󰔡",
  switch_off = "󰨙",

  close = "󰅖",
  view_dashboard = "󰕮",
  message = "󰍡",
  message_badge = "󱥁",

  -- tags
  web = "󰇩",
  files = "",
  console = "󰞷",
  code = "󰅩",
  music = "󰝚",
  lab = "󰂔",
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
  return muted and icons.volume_mute or icons.volume
end

icons.get_wifi = function(perc)
  perc = math.min(99, math.max(perc, 0))
  return icons.wifi_strength[perc // 25 + 1]
end

local ICON_PATH = gears.filesystem.get_configuration_dir() .. "theme/icons/%s.svg"
return setmetatable(icons, {
  __call = function(_, name, color)
    local icon = ICON_PATH:format(name)
    if color then
      return gears.color.recolor_image(icon, color or beautiful.fg_normal)
    end
    return icon
  end,
})
