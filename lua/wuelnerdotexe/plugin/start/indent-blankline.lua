return {
  "lukas-reineke/indent-blankline.nvim",
  event = require("wuelnerdotexe.plugin.config").open_file_event,
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("indent_blankline").setup({
      use_treesitter = true,
      show_current_context = true,
      show_current_context_start = true,
      show_trailing_blankline_indent = false,
      char = "▏",
      context_char = "▏",
      buftype_exclude = { "help", "loclist", "nofile", "prompt", "quickfix", "terminal" },
      filetype_exclude = { "list" },
    })
  end,
}
