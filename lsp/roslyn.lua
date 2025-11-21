return {
  capabilities = {
    textDocument = {
      semanticTokens = vim.NIL,
    },
  },
  settings = {
    ["csharp|background_analysis"] = {
      dotnet_analyzer_diagnostics_scope = "openFiles",
      dotnet_compiler_diagnostics_scope = "openFiles",
    },
  },
}
