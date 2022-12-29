local M = {}

-- merges recursively two map-like tables, use value from rightmost if repeated
-- keys are found
M.deep_extend = function(target, source)
  -- TODO: deep copy target
  for k, v in pairs(source or {}) do
    if type(v) == "table" then
      if type(target[k]) ~= "table" then
        target[k] = {}
      end
      target[k] = M.deep_extend(target[k] or {}, v)
    else -- simply copy for non-table
      target[k] = v
    end
  end
  return target
end

return M
