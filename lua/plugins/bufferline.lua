return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons", "ibhagwan/fzf-lua" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          show_close_icon = false,
          custom_filter = function(buf)
            local buftype = vim.bo[buf].buftype
            local filetype = vim.bo[buf].filetype

            if buftype == "quickfix" or buftype == "help" or buftype == "nofile" then
              return false
            end

            local excluded_filetypes = {
              "qf",
              "help",
              "fugitive",
              "git",
            }

            for _, ft in ipairs(excluded_filetypes) do
              if filetype == ft then
                return false
              end
            end

            return true
          end,
          groups = {
            items = {
              require("bufferline.groups").builtin.pinned:with({ icon = "◉" })
            }
          }
        }
      })

      vim.keymap.set("n", "H", "<CMD>BufferLineCyclePrev<CR>", {
        silent = true,
        noremap = true,
        desc = "Previous buffer"
      })
      vim.keymap.set("n", "L", "<CMD>BufferLineCycleNext<CR>", {
        silent = true,
        noremap = true,
        desc = "Next buffer"
      })

      vim.keymap.set("n", "<M-h>", "<CMD>BufferLineMovePrev<CR>", {
        silent = true,
        noremap = true,
        desc = "Move buffer left"
      })
      vim.keymap.set("n", "<M-l>", "<CMD>BufferLineMoveNext<CR>", {
        silent = true,
        noremap = true,
        desc = "Move buffer right"
      })

      vim.keymap.set("n", "<C-q>", "<CMD>bd<CR>", {
        silent = true,
        desc = "Close buffer"
      })
      vim.keymap.set("n", "<M-q>", "<CMD>BufferLineCloseOthers<CR>", {
        silent = true,
        noremap = true,
        desc = "Close other buffers"
      })

      vim.keymap.set("n", "<leader>bb", function()
        require("fzf-lua").buffers()
      end, {
        desc = "Pick buffer"
      })
      vim.keymap.set("n", "<leader>bc", "<CMD>bd<CR>", {
        silent = true,
        desc = "Close buffer"
      })
      vim.keymap.set("n", "<leader>bC", "<CMD>BufferLineCloseOthers<CR>", {
        silent = true,
        noremap = true,
        desc = "Close other buffers"
      })
      vim.keymap.set("n", "<leader>bp", "<CMD>BufferLineTogglePin<CR>", {
        silent = true,
        noremap = true,
        desc = "Toggle pin"
      })
      vim.keymap.set("n", "<leader>bx", "<CMD>BufferLineGroupClose ungrouped<CR>", {
        silent = true,
        noremap = true,
        desc = "Close unpinned buffers"
      })
      vim.keymap.set("n", "<leader>bl", "<CMD>BufferLineMoveNext<CR>", {
        silent = true,
        noremap = true,
        desc = "Move buffer right"
      })
      vim.keymap.set("n", "<leader>bh", "<CMD>BufferLineMovePrev<CR>", {
        silent = true,
        noremap = true,
        desc = "Move buffer left"
      })
    end,
  },
  {
    "tiagovla/scope.nvim",
    config = function()
      require("scope").setup()
    end,
  },
}
