return {
  'seblyng/roslyn.nvim',
  ft = { 'cs', 'vb' },
  opts = {
    -- Disable filewatching for better performance
    filewatching = "off",

    -- Automatically search parent directories for .sln files
    broad_search = true,

    -- Lock to the first solution found to prevent constant switching
    lock_target = false,
  },
}
