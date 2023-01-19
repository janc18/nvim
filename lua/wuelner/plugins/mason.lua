return {
  "williamboman/mason.nvim",
  lazy = true,
  config = function()
    require("mason").setup({
      ui = {
        border = "rounded",
        icons = { package_installed = "✓", package_pending = "⟳", package_uninstalled = "-" },
        keymaps = { uninstall_package = "d" },
      },
    })
  end,
}
