local M = {
  keys = require("configs.keys"),
  colors = require("configs.colors"),
}
return M
-- local PREFIX = ... .. "."
-- return setmetatable({}, {
--   __index = function(self, k)
--     local m = self[k]
--     if m == nil then
--       m = require(PREFIX .. k)
--       rawset(self, k, m)
--     end
--     return m
--   end,
-- })
