return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
        delay = 200,
        win = {
          border = "rounded",
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
        show_help = true,
        show_keys = true,
      })

      wk.add({
        { "<leader>",    group = "leader" },
        { "<leader>c",   group = "comment" },
        { "<leader>cc",  desc = "Toggle line comment" },
        { "<leader>cb",  desc = "Toggle block comment" },
        { "<leader>cv",  group = "operator" },
        { "<leader>cvc", desc = "Line comment with motion" },
        { "<leader>cvb", desc = "Block comment with motion" },
        { "<leader>f",   group = "find/search" },
        { "<leader>g",   group = "git" },
        { "<leader>l",   group = "lsp" },
        { "g",           group = "goto" },
        { "<C-w>",       group = "window" },
      })
    end
  }
}
