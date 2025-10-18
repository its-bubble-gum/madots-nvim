return {
  "cpplain/flexoki.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    vim.cmd("colorscheme flexoki")
  end
}
