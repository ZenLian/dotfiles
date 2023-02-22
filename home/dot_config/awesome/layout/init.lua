local top_panel = require("layout.top_panel")
local exit_screen = require("layout.exit_screen")

screen.connect_signal("request::desktop_decoration", function(s)
  s.top_panel = top_panel(s)
  s.exit_screen = exit_screen(s)
end)
