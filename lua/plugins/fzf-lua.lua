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
      desc = "find [f]iles"
    })

    vim.keymap.set("n", "<leader>fb", fzf.buffers, {
      desc = "find [b]uffers"
    })

    vim.keymap.set("n", "<leader>ft", fzf.tabs, {
      desc = "find [t]abs"
    })

    vim.keymap.set("n", "<leader>fr", fzf.oldfiles, {
      desc = "[r]ecent files"
    })

    vim.keymap.set("n", "<leader>fh", fzf.help_tags, {
      desc = "[h]elp tags"
    })

    vim.keymap.set("n", "<leader>fg", fzf.live_grep, {
      desc = "live [g]rep"
    })

    vim.keymap.set("n", "<leader>fw", fzf.grep_cword, {
      desc = "search [w]ord under cursor"
    })

    vim.keymap.set("n", "<leader>fW", fzf.grep_cWORD, {
      desc = "search [W]ORD under cursor"
    })

    vim.keymap.set("n", "<leader>f/", fzf.grep_curbuf, {
      desc = "search current buffer ([/])"
    })
  end
}
