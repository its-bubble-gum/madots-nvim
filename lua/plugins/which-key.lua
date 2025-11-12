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
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "comment" },
        { "<leader>cv", group = "operator" },
        { "<leader>f", group = "find/search" },
        { "<leader>g", group = "git" },
        { "<leader>gb", group = "blame" },
        { "<leader>gh", group = "hunk" },
        { "<leader>gp", group = "pull requests" },
        { "<leader>gc", group = "comments" },
        { "<leader>gd", group = "diffview" },
        { "<leader>s", group = "search/replace" },
        { "<leader>r", group = "surround" },
        { "<leader>ra", desc = "Add surround", mode = { "n", "v" } },
        { "<leader>rr", desc = "Surround line" },
        { "<leader>rd", desc = "Delete surround" },
        { "<leader>rc", desc = "Change surround" },
        { "<leader>l", group = "lsp" },
        { "g", group = "goto" },
        { "<C-w>", group = "window" },
      })
    end
  }
}
