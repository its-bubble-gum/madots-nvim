-- Load LSP utilities
local lsp_utils = require('config.lsp.utils')

-- OmniSharp progress tracking
local omnisharp_startup_handles = {}
local omnisharp_loading_handles = {}

-- Track when C# files are opened and show loading
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cs', 'vb' },
  callback = function(args)
    if not omnisharp_startup_handles[args.buf] then
      local ok, fidget = pcall(require, 'fidget.progress')
      if ok then
        omnisharp_startup_handles[args.buf] = fidget.handle.create({
          title = 'omnisharp',
          message = 'Starting OmniSharp...',
        })
      end
    end
  end,
})

-- Clean up startup handles when buffers are deleted
vim.api.nvim_create_autocmd('BufDelete', {
  callback = function(args)
    if omnisharp_startup_handles[args.buf] then
      omnisharp_startup_handles[args.buf] = nil
    end
  end,
})

-- LSP keymaps and buffer-local setup
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
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
      vim.keymap.set("n", "<leader>ld", lsp_utils.lsp_definition, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Definition"
      })
    end

    if client:supports_method('textDocument/declaration') then
      vim.keymap.set("n", "<leader>lD", lsp_utils.lsp_declaration, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Declaration"
      })
    end

    if client:supports_method('textDocument/references') then
      vim.keymap.set("n", "<leader>lr", lsp_utils.lsp_references, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "References"
      })
    end

    if client:supports_method('textDocument/implementation') then
      vim.keymap.set("n", "<leader>li", lsp_utils.lsp_implementation, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "Implementation"
      })
    end

    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set("n", "<leader>lt", lsp_utils.lsp_type_definition, {
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

-- OmniSharp progress-related configuration
-- Note: Basic config (settings, omnisharp_extended handlers) is in lsp/omnisharp.lua
-- This adds progress tracking handlers that depend on local variables
vim.lsp.config('omnisharp', {
  handlers = {
    ['o#/projectadded'] = function(err, result, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if client then
        local ok, fidget = pcall(require, 'fidget.progress')
        if not ok then return end

        local project_name = vim.fn.fnamemodify(result.MsBuildProject.Path or 'Unknown', ':t')

        -- Finish loading progress handle
        if omnisharp_loading_handles[client.id] then
          omnisharp_loading_handles[client.id]:finish()
          omnisharp_loading_handles[client.id] = nil
        end

        -- Show completion message
        fidget.handle.create({
          title = 'omnisharp',
          message = string.format('✓ Loaded %s', project_name),
          lsp_client = client,
        }):finish()
      end
    end,
    ['o#/projectchanged'] = function(err, result, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      if client then
        local ok, fidget = pcall(require, 'fidget.progress')
        if not ok then return end

        local project_name = vim.fn.fnamemodify(result.MsBuildProject.Path or 'Unknown', ':t')

        fidget.handle.create({
          title = 'omnisharp',
          message = string.format('Project changed: %s', project_name),
          lsp_client = client,
        }):finish()
      end
    end,
  },
  on_attach = function(client, bufnr)
    -- Finish startup handle and create loading project handle
    if not omnisharp_loading_handles[client.id] then
      local ok, fidget = pcall(require, 'fidget.progress')
      if ok then
        -- Finish the "Starting OmniSharp..." handle
        if omnisharp_startup_handles[bufnr] then
          omnisharp_startup_handles[bufnr]:finish()
          omnisharp_startup_handles[bufnr] = nil
        end

        -- Create "Loading project..." handle
        omnisharp_loading_handles[client.id] = fidget.handle.create({
          title = 'omnisharp',
          message = 'Loading project...',
          lsp_client = client,
        })
      end
    end

    -- OmniSharp attaches before capabilities are ready, so we need to wait
    local function try_setup_keymaps(attempts)
      attempts = attempts or 0
      if attempts > 10 then
        vim.notify('OmniSharp: Gave up waiting for capabilities after 10 attempts', vim.log.levels.WARN)
        return
      end

      if client:supports_method('textDocument/definition') then
        -- Manually fire LspAttach again now that capabilities are ready
        vim.api.nvim_exec_autocmds('LspAttach', {
          buffer = bufnr,
          data = { client_id = client.id }
        })
      else
        vim.defer_fn(function()
          try_setup_keymaps(attempts + 1)
        end, 500)
      end
    end

    try_setup_keymaps()
  end,
})

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = {
    current_line = true,
  },
  underline = true,
  update_in_insert = true
})

-- Enable LSP servers
-- Server configs are in lsp/ directory
vim.lsp.enable('ccls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('angularls')
vim.lsp.enable('eslint')
vim.lsp.enable('vtsls')
vim.lsp.enable('omnisharp')
