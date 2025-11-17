vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.foldmethod = "marker"
vim.opt.scrolloff = 10
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.o.completeopt = 'menuone,preview,noselect'

-- Sync clipboard with system
vim.opt.clipboard = "unnamedplus"

-- Disable built-in completion
vim.g.loaded_completion = 1

-- Override vim-sleuth's tabstop setting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt_local.tabstop = 2
  end,
})
