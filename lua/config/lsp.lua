vim.lsp.enable('ccls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('angularls')
vim.lsp.enable('eslint')
vim.lsp.enable('vtsls')

vim.lsp.config('vtsls', {
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
  capabilities = {
    textDocument = {
      formatting = false
    }
  }
})

vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = {
    current_line = true,
  },
  underline = true,
  update_in_insert = true
})

local function deduplicate_lsp_results(results)
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

local function lsp_definition()
  vim.lsp.buf.definition({ on_list = function(options)
    local items = deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('cfirst')
  end })
end

local function lsp_declaration()
  vim.lsp.buf.declaration({ on_list = function(options)
    local items = deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('cfirst')
  end })
end

local function lsp_references()
  vim.lsp.buf.references(nil, { on_list = function(options)
    local items = deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('copen')
  end })
end

local function lsp_implementation()
  vim.lsp.buf.implementation({ on_list = function(options)
    local items = deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('cfirst')
  end })
end

local function lsp_type_definition()
  vim.lsp.buf.type_definition({ on_list = function(options)
    local items = deduplicate_lsp_results(options.items)
    vim.fn.setqflist({}, ' ', { title = options.title, items = items, context = options.context })
    vim.api.nvim_command('cfirst')
  end })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    local format_on_save_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" }
    local should_format_on_save = vim.tbl_contains(format_on_save_filetypes, vim.bo[args.buf].filetype)

    if should_format_on_save
        and not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end

    if client:supports_method('textDocument/hover') then
      vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Hover"
      })

      vim.keymap.del("n", "K", { buffer = args.buf })
    end

    if client:supports_method('textDocument/definition') then
      vim.keymap.set("n", "<leader>ld", lsp_definition, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Definition"
      })
    end

    if client:supports_method('textDocument/declaration') then
      vim.keymap.set("n", "<leader>lD", lsp_declaration, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Declaration"
      })
    end

    if client:supports_method('textDocument/references') then
      vim.keymap.set("n", "<leader>lr", lsp_references, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "References"
      })
    end

    if client:supports_method('textDocument/implementation') then
      vim.keymap.set("n", "<leader>li", lsp_implementation, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Implementation"
      })
    end

    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set("n", "<leader>lt", lsp_type_definition, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Type definition"
      })
    end

    if client:supports_method('textDocument/formatting') then
      vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
      end, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Format"
      })
    end

    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Code action"
      })
    end

    if client:supports_method('textDocument/rename') then
      vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Rename"
      })
    end

    if client:supports_method('textDocument/inlayHint') then
      vim.keymap.set("n", "<leader>lH", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
      end, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Toggle inlay hints"
      })
    end

    -- Diagnostic list keymaps
    vim.keymap.set("n", "<leader>lq", function()
      vim.diagnostic.setqflist()
    end, {
      noremap = true,
      silent = true,
      buffer = args.buf,
      desc = "Diagnostics quickfix list"
    })

    vim.keymap.set("n", "<leader>ll", function()
      vim.diagnostic.setloclist()
    end, {
      noremap = true,
      silent = true,
      buffer = args.buf,
      desc = "Diagnostics location list"
    })
  end,
})
