-- Window navigation keymaps

local M = {}

function M.setup()
  -- Navigate between windows using Ctrl+hjkl
  vim.keymap.set("n", "<C-h>", "<CMD>wincmd h<CR>", {
    silent = true,
    noremap = true,
    desc = "Move to left window"
  })

  vim.keymap.set("n", "<C-j>", "<CMD>wincmd j<CR>", {
    silent = true,
    noremap = true,
    desc = "Move to bottom window"
  })

  vim.keymap.set("n", "<C-k>", "<CMD>wincmd k<CR>", {
    silent = true,
    noremap = true,
    desc = "Move to top window"
  })

  vim.keymap.set("n", "<C-l>", "<CMD>wincmd l<CR>", {
    silent = true,
    noremap = true,
    desc = "Move to right window"
  })
end

return M
