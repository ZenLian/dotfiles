local M = require(... .. ".core")

local NAME = ... .. "."

return setmetatable(M, {
  __index = function(self, key)
    local service = require(NAME .. key)
    rawset(self, key, service)
    return service
  end,
})
