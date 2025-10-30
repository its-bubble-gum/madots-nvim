return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").open()
      end,
      desc = "Replace in files (Spectre)",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Replace word under cursor (Spectre)",
    },
    {
      "<leader>sf",
      function()
        require("spectre").open_file_search()
      end,
      desc = "Replace in current file (Spectre)",
    },
  },
  opts = {
    open_cmd = "noswapfile vnew",
  },
}
