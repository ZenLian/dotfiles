local awful = require("awful")

local factory = function()
  local kbd = awful.widget.keyboardlayout()

  kbd:connect_signal("button::press", function()
    kbd:next_layout()
  end)

  return kbd
end

return factory
