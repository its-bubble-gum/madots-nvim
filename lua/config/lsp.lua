local lsp_utils = require('config.lsp.utils')

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method('textDocument/hover') then
      vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "[h]over"
      })

      vim.keymap.del("n", "K", { buffer = args.buf })
    end

    if client:supports_method('textDocument/definition') then
      vim.keymap.set("n", "<leader>ld", lsp_utils.lsp_definition, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "[d]efinition"
      })
    end

    if client:supports_method('textDocument/declaration') then
      vim.keymap.set("n", "<leader>lD", lsp_utils.lsp_declaration, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "[D]eclaration"
      })
    end

    if client:supports_method('textDocument/references') then
      vim.keymap.set("n", "<leader>lr", lsp_utils.lsp_references, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "[r]eferences"
      })
    end

    if client:supports_method('textDocument/implementation') then
      vim.keymap.set("n", "<leader>li", lsp_utils.lsp_implementation, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "[i]mplementation"
      })
    end

    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set("n", "<leader>lt", lsp_utils.lsp_type_definition, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "[t]ype definition"
      })
    end

    if client:supports_method('textDocument/formatting') then
      vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
      end, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "[f]ormat"
      })
    end

    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "code [a]ction"
      })
    end

    if client:supports_method('textDocument/rename') then
      vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "re[n]ame"
      })
    end

    if client:supports_method('textDocument/inlayHint') then
      vim.keymap.set("n", "<leader>lH", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
      end, {
        noremap = true,
        silent = true,
        buffer = args.buf,
        desc = "toggle inlay [H]ints"
      })
    end

    vim.keymap.set("n", "<leader>lq", function()
      vim.diagnostic.setqflist()
    end, {
      noremap = true,
      silent = true,
      buffer = args.buf,
      desc = "diagnostics [q]uickfix list"
    })

    vim.keymap.set("n", "<leader>ll", function()
      vim.diagnostic.setloclist()
    end, {
      noremap = true,
      silent = true,
      buffer = args.buf,
      desc = "diagnostics [l]ocation list"
    })
  end,
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true,
  underline = true,
  update_in_insert = false
})

vim.lsp.enable('ccls')
vim.lsp.enable('lua_ls')
vim.lsp.enable('angularls')
vim.lsp.enable('eslint')
vim.lsp.enable('vtsls')
vim.lsp.enable('roslyn')
vim.lsp.enable('markdown_oxide')
