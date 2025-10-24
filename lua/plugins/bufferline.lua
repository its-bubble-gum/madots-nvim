return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup({
      options = {
        diagnostics = "nvim_lsp",
        show_close_icon = false
      }
    })

    vim.keymap.set("n", "H", "<CMD>BufferLineCyclePrev<CR>", {
      silent = true,
      noremap = true
    })
    vim.keymap.set("n", "L", "<CMD>BufferLineCycleNext<CR>", {
      silent = true,
      noremap = true
    })

    vim.keymap.set("n", "<M-h>", "<CMD>BufferLineMovePrev<CR>", {
      silent = true,
      noremap = true
    })
    vim.keymap.set("n", "<M-l>", "<CMD>BufferLineMoveNext<CR>", {
      silent = true,
      noremap = true
    })
  end,
}
