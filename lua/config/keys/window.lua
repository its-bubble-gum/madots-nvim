local M = {}

function M.setup()
  vim.keymap.set("n", "<C-h>", "<CMD>wincmd h<CR>", {
    silent = true,
    noremap = true,
    desc = "move to left window"
  })

  vim.keymap.set("n", "<C-j>", "<CMD>wincmd j<CR>", {
    silent = true,
    noremap = true,
    desc = "move to bottom window"
  })

  vim.keymap.set("n", "<C-k>", "<CMD>wincmd k<CR>", {
    silent = true,
    noremap = true,
    desc = "move to top window"
  })

  vim.keymap.set("n", "<C-l>", "<CMD>wincmd l<CR>", {
    silent = true,
    noremap = true,
    desc = "move to right window"
  })
end

return M
