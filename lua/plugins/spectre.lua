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
      desc = "[r]eplace in files (spectre)",
    },
    {
      "<leader>sw",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "replace [w]ord under cursor (spectre)",
    },
    {
      "<leader>sf",
      function()
        require("spectre").open_file_search()
      end,
      desc = "replace in current [f]ile (spectre)",
    },
  },
  opts = {
    open_cmd = "noswapfile vnew",
  },
}
