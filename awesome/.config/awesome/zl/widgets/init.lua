return setmetatable({}, {
  __index = function(self, key)
    local widget = require("zl.widgets." .. key)
    rawset(self, key, widget)
    -- self[key] = widget
    return widget
  end,
})
