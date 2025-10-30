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
        { "<leader>g",    group = "git" },
        { "<leader>s",   group = "search/replace" },
        { "<leader>sr",  desc = "Replace in files" },
        { "<leader>sw",  desc = "Replace word under cursor" },
        { "<leader>sf",  desc = "Replace in current file" },
        { "<leader>gp",   group = "pull requests" },
        { "<leader>gps",  desc = "Select PR" },
        { "<leader>gpc",  desc = "Checkout PR" },
        { "<leader>gpv",  desc = "View PR" },
        { "<leader>gpd",  desc = "PR diff" },
        { "<leader>gpdv", desc = "PR diffview" },
        { "<leader>gpl",  desc = "Load PR comments" },
        { "<leader>gpa",  desc = "Approve PR" },
        { "<leader>gpr",  desc = "Request changes" },
        { "<leader>gpm",  desc = "Merge PR" },
        { "<leader>gc",   group = "comments" },
        { "<leader>gcp",  desc = "Add PR comment" },
        { "<leader>gca",  desc = "Add inline comment" },
        { "<leader>gcu",  desc = "Update comment" },
        { "<leader>gcd",  desc = "Delete comment" },
        { "<leader>gco",  desc = "Open comment in browser" },
        { "<leader>gd",   group = "diffview" },
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
