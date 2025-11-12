return {
  'kylechui/nvim-surround',
  version = "*",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "<leader>ra",
        normal_cur = "<leader>rA",
        normal_line = "<leader>rr",
        normal_cur_line = "<leader>rR",
        visual = "<leader>ra",
        visual_line = "<leader>rA",
        delete = "<leader>rd",
        change = "<leader>rc",
        change_line = "<leader>rC",
      },
    })
  end
}
