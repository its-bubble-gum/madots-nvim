return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require('notify')
    notify.setup {
      fps = 30,
      render = "wrapped-compact",
      stages = "fade"
    }
    vim.notify = notify
  end
}
