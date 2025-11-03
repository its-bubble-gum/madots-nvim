return {
  settings = {
    -- Disabled for performance in large projects
    enable_roslyn_analyzers = false,
    organize_imports_on_format = false,
    enable_import_completion = false,

    -- Performance optimizations
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = false,
      EnableImportCompletion = false,
      AnalyzeOpenDocumentsOnly = true,
    },
  },
  handlers = {
    ['textDocument/definition'] = function(...)
      return require('omnisharp_extended').handler(...)
    end,
    ['textDocument/typeDefinition'] = function(...)
      return require('omnisharp_extended').type_definition_handler(...)
    end,
    ['textDocument/references'] = function(...)
      return require('omnisharp_extended').references_handler(...)
    end,
    ['textDocument/implementation'] = function(...)
      return require('omnisharp_extended').implementation_handler(...)
    end,
  },
}
