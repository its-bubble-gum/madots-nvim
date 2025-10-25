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
        { "<leader>",  group = "leader" },
        { "<leader>c", group = "comment" },
        { "<leader>f", group = "find/search" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp" },
        { "g",         group = "goto" },
        { "<C-w>",     group = "window" },
      })
    end
  }
}
