return {
  -- Performance optimizations
  capabilities = {
    -- Disable semantic tokens to reduce processing overhead
    textDocument = {
      semanticTokens = vim.NIL,
    },
  },
  settings = {
    -- Roslyn-specific settings for performance
    ["csharp|background_analysis"] = {
      dotnet_analyzer_diagnostics_scope = "openFiles",
      dotnet_compiler_diagnostics_scope = "openFiles",
    },
  },
}
