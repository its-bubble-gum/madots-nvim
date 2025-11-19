return {
  "stevearc/aerial.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "ibhagwan/fzf-lua",
  },
  config = function()
    require("aerial").setup({
      backends = { "treesitter", "lsp", "markdown" },
      attach_mode = "global",
      show_guides = true,
    })

    vim.keymap.set("n", "<leader>fa", "<cmd>AerialNavToggle<CR>", { desc = "[a]erial symbols" })
  end
}
