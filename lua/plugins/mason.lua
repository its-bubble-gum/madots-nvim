return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup({
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",  -- Custom registry for roslyn
      },
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })
  end
}
