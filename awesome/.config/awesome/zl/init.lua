local config = require("zl.config")

local M = {}

M.setup = function(options)
  config.setup(options)

  require("zl.theme").setup()
  require("zl.modules")
  require("zl.screen")
  require("zl.service").run()
end

return M
