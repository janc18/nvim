local M = {}

M.setup = function()
  local set_var = vim.api.nvim_set_var
  local columns = vim.api.nvim_get_option_value("columns", {})

  set_var("fern#disable_default_mappings", 1)
  set_var("fern#default_hidden", 1)
  set_var("fern#default_exclude", [[^\%(\.git\|\.svn\|\.hg\|\CVS\|\.DS_Store\|\Thumbs.db\)$]])
  set_var("fern#drawer_width", math.floor((columns / (columns >= 160 and 3 or 2)) / 2))
  set_var("fern#disable_drawer_hover_popup", 1)
  set_var("fern#drawer_hover_popup_delay", 40)
  set_var("fern_git_status#disable_ignored", 1)
  set_var("fern_git_status#disable_untracked", 1)
  set_var("fern#mark_symbol", "")
  set_var("fern#renderer", "nerdfont")
  set_var("fern#renderer#nerdfont#root_symbol", "")
  set_var("fern#renderer#nerdfont#root_leading", "")
  set_var("fern#renderer#nerdfont#indent_markers", 1)
end

M.config = function()
  local set_option_value = vim.api.nvim_set_option_value
  local call_function = vim.api.nvim_call_function
  local buf_set_keymap = vim.api.nvim_buf_set_keymap

  local keymap_opts = { nowait = true }

  local open_or_collapse = function()
    return call_function("fern#smart#leaf", {
      "<Plug>(fern-action-open)",
      "<Plug>(fern-action-expand)",
      "<Plug>(fern-action-collapse)",
    })
  end

  local open_or_collapse_callback = {
    callback = function()
      open_or_collapse()
    end,
    nowait = true,
    expr = true,
    replace_keycodes = true,
  }

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "fern",
    callback = function(ev)
      call_function("glyph_palette#apply", {})

      local bufnr = ev.buf

      set_option_value("number", false, { buf = bufnr })
      set_option_value("relativenumber", false, { buf = bufnr })

      buf_set_keymap(bufnr, "n", "h", "<Plug>(fern-action-collapse)", keymap_opts)
      buf_set_keymap(bufnr, "n", "l", "<Plug>(fern-action-expand)", keymap_opts)
      buf_set_keymap(bufnr, "n", "<CR>", "<Plug>(fern-action-open-or-expand)", keymap_opts)
      buf_set_keymap(bufnr, "n", "<BS>", "<Plug>(fern-action-collapse)", keymap_opts)
      buf_set_keymap(bufnr, "n", "<C-T>", "<Plug>(fern-action-open:tabedit)", keymap_opts)
      buf_set_keymap(bufnr, "n", "<C-s>", "<Plug>(fern-action-open:split)", keymap_opts)
      buf_set_keymap(bufnr, "n", "nf", "<Plug>(fern-action-new-file)", keymap_opts)
      buf_set_keymap(bufnr, "n", "nd", "<Plug>(fern-action-new-dir)", keymap_opts)
      buf_set_keymap(bufnr, "n", "m", "<Plug>(fern-action-move)", keymap_opts)
      buf_set_keymap(bufnr, "n", "c", "<Plug>(fern-action-copy)", keymap_opts)
      buf_set_keymap(bufnr, "n", "d", "<Plug>(fern-action-remove)", keymap_opts)
      buf_set_keymap(bufnr, "n", "q", "<Cmd>quit<CR>", keymap_opts)
      buf_set_keymap(bufnr, "n", "<F5>", "<Plug>(fern-action-reload)", keymap_opts)
      buf_set_keymap(bufnr, "n", "g?", "<Plug>(fern-action-help)", keymap_opts)
      buf_set_keymap(bufnr, "n", "?", "<Plug>(fern-action-help)", keymap_opts)
      buf_set_keymap(bufnr, "n", "o", "", open_or_collapse_callback)
      buf_set_keymap(bufnr, "n", "<2-LeftMouse>", "", open_or_collapse_callback)
      buf_set_keymap(bufnr, "n", "n", "<Plug>(fern-action-new-path)", {})

      buf_set_keymap(
        bufnr,
        "n",
        "<",
        "<Plug>(fern-action-leave)<Plug>(fern-wait)<Plug>(fern-action-cd:root)<Cmd>echomsg getcwd()<CR>",
        keymap_opts
      )

      buf_set_keymap(
        bufnr,
        "n",
        ">",
        "<Plug>(fern-action-enter)<Plug>(fern-wait)<Plug>(fern-action-cd:root)<Cmd>echomsg getcwd()<CR>",
        keymap_opts
      )

      buf_set_keymap(bufnr, "n", "<C-v>", "", {
        callback = function()
          return call_function("fern#smart#drawer", {
            "<Plug>(fern-action-open:rightest)",
            "<Plug>(fern-action-open:vsplit)",
            "<Plug>(fern-action-open:vsplit)",
          })
        end,
        nowait = true,
        expr = true,
        replace_keycodes = true,
      })
    end,
  })

  vim.api.nvim_set_keymap("n", "<leader>ft", "", {
    callback = function()
      vim.api.nvim_command("Fern . -reveal=% -drawer -toggle")
    end,
  })
end

return M
