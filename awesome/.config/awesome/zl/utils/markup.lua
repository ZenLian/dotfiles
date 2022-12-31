local M = {}

M.fg = function(text, fg)
  return "<span foreground='" .. fg .. "'>" .. text .. "</span>"
end

return M
