return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    max_lines = 5,
    multiline_threshold = 15,
    trim_scope = 'outer',
    min_window_height = 15,
    mode = "topline",
    line_numbers = true,
    zindex = 20,
  }
}
