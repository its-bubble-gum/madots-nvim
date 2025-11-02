local M = {}

function M.deduplicate_lsp_results(results)
  if not results or #results == 0 then
    return results
  end

  local seen = {}
  local deduplicated = {}

  for _, item in ipairs(results) do
    local filename = item.filename
    local lnum = item.lnum
    local col = item.col

    if filename and lnum and col then
      local key = string.format("%s:%d:%d", filename, lnum, col)

      if not seen[key] then
        seen[key] = true
        table.insert(deduplicated, item)
      end
    else
      table.insert(deduplicated, item)
    end
  end

  return deduplicated
end

function M.lsp_definition()
  vim.lsp.buf.definition({ on_list = function(options)
    local items = M.deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('cfirst')
  end })
end

function M.lsp_declaration()
  vim.lsp.buf.declaration({ on_list = function(options)
    local items = M.deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('cfirst')
  end })
end

function M.lsp_references()
  vim.lsp.buf.references(nil, { on_list = function(options)
    local items = M.deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('copen')
  end })
end

function M.lsp_implementation()
  vim.lsp.buf.implementation({ on_list = function(options)
    local items = M.deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('cfirst')
  end })
end

function M.lsp_type_definition()
  vim.lsp.buf.type_definition({ on_list = function(options)
    local items = M.deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('cfirst')
  end })
end

return M
