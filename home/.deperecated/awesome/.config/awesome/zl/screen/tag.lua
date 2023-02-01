local awful = require("awful")

local M = {}

local tags = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

M.init = function(s)
  screen[s].padding = { left = 0, right = 0, top = 0, bottom = 0 }
  awful.tag(tags, s, awful.layout.layouts[1])
end

return M
