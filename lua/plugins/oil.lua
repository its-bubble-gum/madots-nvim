return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-mini/mini.icons" },
  lazy = false,
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "open parent directory", mode = "n" }
  }
}
