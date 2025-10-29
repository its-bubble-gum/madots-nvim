return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
  opts = {
    indent = {
      char = "│",
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
  }
}
