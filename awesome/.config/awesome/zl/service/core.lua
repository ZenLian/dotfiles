local M = {
  status = {
    STOPPED = "stopped",
    STARTING = "starting",
    RUNNING = "running",
  },
}

M.run = function()
  require("zl.service.volume").run()
end

return M
