return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      winopts = {
        height = 0.85,
        width = 0.80,
        border = "rounded",
        preview = {
          default = "bat",
          border = "border",
          layout = "flex",
          flip_columns = 120,
        },
      },
      files = {
        cmd = "fd --type f --strip-cwd-prefix",
        prompt = "Files❯ ",
      },
    })

    vim.keymap.set("n", "<leader>ff", fzf.files, {
      desc = "Find files"
    })

    vim.keymap.set("n", "<leader>fb", fzf.buffers, {
      desc = "Find buffers"
    })

    vim.keymap.set("n", "<leader>ft", fzf.tabs, {
      desc = "Find tabs"
    })

    vim.keymap.set("n", "<leader>fr", fzf.oldfiles, {
      desc = "Recent files"
    })

    vim.keymap.set("n", "<leader>fh", fzf.help_tags, {
      desc = "Help tags"
    })

    vim.keymap.set("n", "<leader>fg", fzf.live_grep, {
      desc = "Live grep"
    })

    vim.keymap.set("n", "<leader>fw", fzf.grep_cword, {
      desc = "Search word under cursor"
    })

    vim.keymap.set("n", "<leader>fW", fzf.grep_cWORD, {
      desc = "Search WORD under cursor"
    })

    vim.keymap.set("n", "<leader>f/", fzf.grep_curbuf, {
      desc = "Search current buffer"
    })
  end
}
