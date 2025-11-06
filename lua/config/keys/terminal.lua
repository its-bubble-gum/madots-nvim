local M = {}

function M.toggle_terminal()
  local current_buf = vim.api.nvim_get_current_buf()
  local ok, is_pinned_term = pcall(vim.api.nvim_buf_get_var, current_buf, 'pinned_terminal')

  if ok and is_pinned_term then
    local all_bufs = vim.fn.getbufinfo({ buflisted = 1 })

    if #all_bufs > 1 then
      vim.cmd("bprevious")
    else
      vim.cmd("stopinsert")
    end
  else
    local term_buf = nil
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
        ok, is_pinned_term = pcall(vim.api.nvim_buf_get_var, buf, "pinned_terminal")
        if ok and is_pinned_term then
          term_buf = buf
          break
        end
      end
    end

    if term_buf then
      vim.api.nvim_set_current_buf(term_buf)
      vim.cmd("startinsert")
    else
      vim.cmd("terminal")
      local new_term_buf = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_var(new_term_buf, "pinned_terminal", true)
      vim.schedule(function()
        vim.cmd("BufferLineTogglePin")
      end)
      vim.cmd("startinsert")
    end
  end
end

function M.setup()
  vim.keymap.set({ "n", "t" }, "<C-\\><C-\\>", M.toggle_terminal, {
    silent = true,
    noremap = true,
    desc = "Toggle terminal buffer"
  })
end

return M
