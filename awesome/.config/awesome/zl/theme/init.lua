local utils = require("zl.utils")

local PREFIX = ...

local M = {
  icons = require(... .. ".icons"),
}

function M.init()
  local O = require("zl.config").theme
  local dpi = require("beautiful.xresources").apply_dpi

  -- init material design tokens
  -- TODO: handle missing properties
  local spec = require(PREFIX .. ".themes." .. O.name)
  local c = spec.color

  local defaults = {
    wibar = {
      height = dpi(32),
      bg = c.background,
    },
    control_center = {
      width = dpi(400),
      height = dpi(300),
      spacing = dpi(20),
      bg = c.background,
      surface = c.surface,
    },
  }
  -- }}}

  spec = utils.table.extend(defaults, spec)

  setmetatable(M, { __index = spec })
  -- for k, v in pairs(theme) do
  --   M[k] = v
  -- end

  -- init awesome's beautiful module
  require(PREFIX .. ".beautiful").init(M)
end

return M

--vim:foldmethod=marker:foldmarker={{{,}}}:
