return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      icons_enabled = true,
      theme = 'auto',
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff', 'diagnostics'},
      lualine_c = {'filename'},
      lualine_x = {
        {
          function()
            local clients = vim.lsp.get_clients({ bufnr = 0 })
            if #clients == 0 then
              return ''
            end
            local names = {}
            for _, client in ipairs(clients) do
              table.insert(names, client.name)
            end
            return '󰒋 ' .. table.concat(names, ', ')
          end,
        },
        {
          function()
            if vim.bo.expandtab then
              return 'Spaces: ' .. vim.bo.shiftwidth
            else
              return 'Tabs: ' .. vim.bo.tabstop
            end
          end,
        },
        'encoding',
        'fileformat',
        'filetype'
      },
      lualine_y = {'progress'},
      lualine_z = {'location'}
    },
    winbar = {
      lualine_c = {
        { 'filename', path = 1 }
      }
    },
    inactive_winbar = {
      lualine_c = {
        { 'filename', path = 1 }
      }
    },
  }
}
