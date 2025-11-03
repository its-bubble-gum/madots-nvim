-- Load LSP utilities
local lsp_utils = require('config.lsp.utils')

-- LSP keymaps and buffer-local setup
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Performance: Disable autotrigger for heavy LSPs (roslyn)
    local autotrigger = client.name ~= 'roslyn'

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = autotrigger })
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

-- Diagnostic configuration
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,  -- Disable to reduce overhead
  underline = true,
  update_in_insert = false  -- Critical: only update diagnostics after leaving insert mode
})

-- Enable LSP servers
-- Server configs are in lsp/ directory
vim.lsp.enable('ccls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('angularls')
vim.lsp.enable('eslint')
vim.lsp.enable('vtsls')
vim.lsp.enable('roslyn')
