local setup = function()
  local set_var = vim.api.nvim_set_var

  set_var("sleuth_aerial_heuristics", 0)
  set_var("sleuth_checkhealth_heuristics", 0)
  set_var("sleuth_dapui_breakpoints_heuristics", 0)
  set_var("sleuth_dapui_console_heuristics", 0)
  set_var("sleuth_dapui_hover_heuristics", 0)
  set_var("sleuth_dapui_scopes_heuristics", 0)
  set_var("sleuth_dapui_stacks_heuristics", 0)
  set_var("sleuth_dapui_watches_heuristics", 0)
  set_var("sleuth_fern_heuristics", 0)
  set_var("sleuth_list_heuristics", 0)
  set_var("sleuth_lspinfo_heuristics", 0)
  set_var("sleuth_mason_heuristics", 0)
  set_var("sleuth_nerdterm_heuristics", 0)
  set_var("sleuth_noice_heuristics", 0)
  set_var("sleuth_notify_heuristics", 0)
  set_var("sleuth_packer_heuristics", 0)
  set_var("sleuth_qf_heuristics", 0)
  set_var("sleuth_TelescopePrompt_heuristics", 0)
end

return setup
