return {
  "ej-shafran/compile-mode.nvim",
  branch = "latest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  keys = {
    { "<C-\\><C-'>", "<CMD>tab Compile<CR>", mode = "n", desc = "Compile mode" }
  },
  config = function()
    vim.g.compile_mode = {
      baleia_setup = true,
      bang_expansion = true,
    }
  end
}
