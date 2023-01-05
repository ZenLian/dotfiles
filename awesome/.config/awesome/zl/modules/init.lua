local C = require("zl.config")

-- {{{ misc stuff
require("awful.autofocus")
require("awful.util").shell = "bash"
require("menubar.utils").terminal = C.apps.terminal

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--   c:activate { context = "mouse_enter", raise = false }
-- end)

--- {{{ modules
require("zl.modules.menu")
require("zl.modules.layout")
require("zl.modules.keys")
require("zl.modules.rules")
require("zl.modules.autostart")
-- }}}
