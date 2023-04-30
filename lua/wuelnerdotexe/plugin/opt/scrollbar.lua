return {
  "petertriho/nvim-scrollbar",
  enabled = not require("wuelnerdotexe.plugin.config").minimal_setup,
  event = "VeryLazy",
  config = function()
    require("scrollbar").setup({
      throttle_ms = 42,
      handle = { highlight = "PmenuSbar" },
      marks = {
        Error = { highlight = "DiagnosticError" },
        Warn = { highlight = "DiagnosticWarn" },
        Info = { highlight = "DiagnosticInfo" },
        Hint = { highlight = "DiagnosticHint" },
      },
      excluded_buftypes = { "prompt" },
      excluded_filetypes = {
        "dapui_hover",
        "DressingInput",
        "DressingSelect",
        "noice",
        "TelescopePrompt",
      },
    })
  end,
}
