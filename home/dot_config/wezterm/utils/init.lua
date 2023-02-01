local M = {}

M.table_extend = function(dst, ...)
  local n = select("#", ...)
  for i = 1, n do
    local src = select(i, ...)
    for k, v in pairs(src) do
      dst[k] = v
    end
  end
  return dst
end

return M
