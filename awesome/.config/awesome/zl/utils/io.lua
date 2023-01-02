local M = {}

M.first_line = function(path)
  local line = nil
  local f = io.open(path, "rb")
  if f then
    line = f:read("*l")
    f:close()
  end
  return line
end

return M
