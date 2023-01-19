return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").fd()
      end,
    },
    {
      "<leader>of",
      function()
        require("telescope.builtin").oldfiles()
      end,
    },
    {
      "<leader>mf",
      function()
        require("telescope.builtin").marks()
      end,
    },
    {
      "<leader>wf",
      function()
        require("telescope.builtin").live_grep()
      end,
    },
    {
      "<leader>pf",
      function()
        vim.api.nvim_command("Telescope projections")
      end,
    },
  },
  dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
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
        layout_config = {
          prompt_position = "top",
        },
        prompt_prefix = "  ",
        selection_caret = "  ",
        multi_icon = " ",
        winblend = 10,
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
            if not stat or stat.size > 100000 then
              return
            end

            require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
          end)
        end,
        mappings = {
          i = { ["<C-s>"] = "select_horizontal", ["<C-x>"] = false, ["<C-e>"] = "close", ["<C-c>"] = false },
          n = { ["<C-s>"] = "select_horizontal", ["<C-x>"] = false, ["g?"] = "which_key", ["q"] = "close" },
        },
      },
      extensions = { fzf = { case_mode = "ignore_case" } },
    })

    local load_extension = require("telescope").load_extension

    load_extension("fzf")
    load_extension("projections")

    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function()
        vim.api.nvim_set_option_value("wrap", false, { scope = "local" })
      end,
    })
  end,
}
