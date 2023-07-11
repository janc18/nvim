return {
  "rcarriga/nvim-notify",
  cmd = "Notifications",
  lazy = true,
  init = function()
    require("wuelnerdotexe.plugin.util").add_colorscheme_integration("notify")

    require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)

    table.insert(require("wuelnerdotexe.plugin.util").user_interface_filetypes, "notify")

    if require("lazy.core.config").spec.plugins["noice.nvim"] == nil then return end

    vim.api.nvim_create_autocmd("UIEnter", { callback = function() vim.notify = require("notify") end, once = true })
  end,
  config = function() require("notify").setup({ timeout = 3000, stages = "slide", render = "compact", fps = 60 }) end,
}
