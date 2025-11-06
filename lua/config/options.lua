vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.foldmethod = "marker"
vim.opt.scrolloff = 10
vim.o.completeopt = 'menuone,preview,noselect'

-- Override vim-sleuth's tabstop setting
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt_local.tabstop = 2
  end,
})
