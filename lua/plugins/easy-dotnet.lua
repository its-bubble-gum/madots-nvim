return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "ibhagwan/fzf-lua", "mfussenegger/nvim-dap" },
  ft = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
  config = function()
    local dotnet = require("easy-dotnet")

    dotnet.setup({
      debugger = {
        bin_path = nil,
        auto_register_dap = true,
      },
      auto_bootstrap_namespace = {
        enabled = true,
        type = "file_scoped",
      },
      lsp = {
        enabled = false,
      },
    })

    vim.keymap.set("n", "<leader>dnr", dotnet.run, { desc = "[D]ot[n]et [R]un" })
    vim.keymap.set("n", "<leader>dnR", dotnet.run_profile, { desc = "[D]ot[n]et [R]un with profile" })
    vim.keymap.set("n", "<leader>dnb", dotnet.build, { desc = "[D]ot[n]et [B]uild" })
    vim.keymap.set("n", "<leader>dnt", dotnet.test, { desc = "[D]ot[n]et [T]est" })
    vim.keymap.set("n", "<leader>dnT", dotnet.testrunner, { desc = "[D]ot[n]et [T]est runner" })
    vim.keymap.set("n", "<leader>dnc", dotnet.clean, { desc = "[D]ot[n]et [C]lean" })
    vim.keymap.set("n", "<leader>dns", dotnet.restore, { desc = "[D]ot[n]et re[S]tore" })
    vim.keymap.set("n", "<leader>dnp", dotnet.project_view, { desc = "[D]ot[n]et [P]roject view" })
    vim.keymap.set("n", "<leader>dna", dotnet.new, { desc = "[D]ot[n]et [A]dd project" })
    vim.keymap.set("n", "<leader>dnS", dotnet.secrets, { desc = "[D]ot[n]et [S]ecrets" })
    vim.keymap.set("n", "<leader>dnd", function()
      require("easy-dotnet.actions.diagnostics").get_workspace_diagnostics()
    end, { desc = "[D]ot[n]et [D]iagnostics" })
  end
}
