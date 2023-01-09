local M = require(... .. ".core")

local NAME = ... .. "."

M.run = function()
  local services = {
    --
    "volume",
    "brightness",
    "cpu",
    "memory",
    "thermal",
    "battery",
    "network",
    "bluetooth",
    -- "bt",
  }
  for _, name in ipairs(services) do
    require(NAME .. name).run()
  end
end

return setmetatable(M, {
  __index = function(self, key)
    local service = require(NAME .. key)
    rawset(self, key, service)
    return service
  end,
})
