return setmetatable({}, {
  __index = function(self, key)
    local widget = require("zl.widgets." .. key)
    self[key] = widget
    return widget
  end,
})
