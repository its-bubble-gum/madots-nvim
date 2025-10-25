return {
  "huy-hng/anyline.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  opts = {
    indent_char = "│",
    animation = "from_cursor",
    debounce_time = 30,
  }
}
