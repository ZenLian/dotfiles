-- appearance for each screen

local PREFIX = ... .. "."
local submodule = function(name)
  return require(PREFIX .. name)
end

submodule("wallpaper")
submodule("titlebar")
-- autosetup when toggle
submodule("controlCenter").setup()
submodule("notification")

screen.connect_signal("request::desktop_decoration", function(s)
  screen[s].padding = { left = 0, right = 0, top = 0, bottom = 0 }
  submodule("tag").init(s)
  submodule("wibar").init(s)
end)
