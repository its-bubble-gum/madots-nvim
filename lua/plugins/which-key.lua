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
        { "<leader>gp",  group = "pull requests" },
        { "<leader>gpl", desc = "List PRs" },
        { "<leader>gpo", desc = "Open PR" },
        { "<leader>gpc", desc = "Checkout PR" },
        { "<leader>gpd", desc = "PR diff" },
        { "<leader>gpm", desc = "Merge PR" },
        { "<leader>gpa", desc = "Approve PR" },
        { "<leader>gi",  group = "issues" },
        { "<leader>gil", desc = "List issues" },
        { "<leader>gio", desc = "Open issue" },
        { "<leader>gc",  group = "comments" },
        { "<leader>gcc", desc = "Create comment" },
        { "<leader>gf",  group = "fzf git" },
        { "<leader>gfp", desc = "FZF PR picker" },
        { "<leader>gfi", desc = "FZF issue picker" },
        { "<leader>gd",  group = "diffview" },
        { "<leader>gdo", desc = "Open diffview" },
        { "<leader>gdc", desc = "Close diffview" },
        { "<leader>gdh", desc = "File history" },
        { "<leader>gdf", desc = "Current file history" },
        { "<leader>gdr", desc = "Refresh diffview" },
        { "<leader>gdt", desc = "Toggle files panel" },
        { "<leader>l",   group = "lsp" },
        { "g",           group = "goto" },
        { "<C-w>",       group = "window" },
      })
    end
  }
}
