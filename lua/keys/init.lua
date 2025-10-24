-- Keymap configuration loader
-- This module loads all keymap configurations

local M = {}

function M.setup()
  -- Load window navigation keymaps
  require("keys.window").setup()

  -- Load terminal toggle keymaps
  require("keys.terminal").setup()
end

return M
