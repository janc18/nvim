return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "<leader>pf", function() vim.api.nvim_command("Telescope projections") end },
    { "<leader>ff", function() require("telescope.builtin").fd() end },
    { "<leader>of", function() require("telescope.builtin").oldfiles() end },
    { "<leader>mf", function() require("telescope.builtin").marks() end },
    { "<leader>bf", function() require("telescope.builtin").buffers() end },
    { "<leader>wf", function() require("telescope.builtin").live_grep() end },
    { "<leader>gf", function() require("telescope.builtin").git_status() end },
    {
      "<leader>sf",
      function() require("telescope.builtin").fd({ prompt_title = "Neovim Setup", cwd = "$HOME/.config/nvim/" }) end,
    },
    {
      "<leader>df",
      function() require("telescope.builtin").fd({ prompt_title = "dotfiles", cwd = "$HOME/dotfiles/" }) end,
    },
    { "<leader>rf", function() require("telescope.builtin").resume() end },
    { "z=", function() require("telescope.builtin").spell_suggest() end },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "gnikdroy/projections.nvim",
  },
  config = function()
    require("telescope").setup({
      pickers = {
        fd = {
          find_command = {
            "fd",
            "-I",
            "-H",
            "-E",
            "{.git,.svn,.hg,CSV,.DS_Store,Thumbs.db,node_modules,bower_components,*.code-search}",
            "-t",
            "f",
          },
        },
      },
      defaults = {
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
        winblend = require("wuelnerdotexe.plugin.config").blend,
        prompt_prefix = "  ",
        selection_caret = "  ",
        borderchars = require("wuelnerdotexe.plugin.util").get_border().chars,
        mappings = {
          i = { ["<C-y>"] = "select_default", ["<C-x>"] = false, ["<C-s>"] = "select_horizontal" },
          n = { ["q"] = "close", ["g?"] = "which_key", ["<C-x>"] = false, ["<C-s>"] = "select_horizontal" },
        },
        preview = { filesize_limit = false, timeout = 284 },
        vimgrep_arguments = {
          "rg",
          "--hidden",
          "--glob=!{.git,.svn,.hg,CSV,.DS_Store,Thumbs.db,node_modules,bower_components,*.code-search}",
          "--ignore-case",
          "--with-filename",
          "--line-number",
          "--column",
          "--no-heading",
          "--trim",
          "--color=never",
        },
        buffer_previewer_maker = function(filepath, bufnr, opts)
          opts = opts or {}

          vim.loop.fs_stat(filepath, function(_, stat)
            if not stat or stat.size > 102400 then return end

            require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
          end)
        end,
      },
      extensions = { fzf = { case_mode = "ignore_case" } },
    })

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("projections")

    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function(ev)
        vim.api.nvim_set_option_value("number", true, { buf = ev.buf })
        vim.api.nvim_set_option_value("wrap", true, { buf = ev.buf })
      end,
    })
  end,
}
