return {
  "mfussenegger/nvim-dap",
  keys = {
    {
      "<F9>",
      function()
        require("dap").toggle_breakpoint()
      end,
    },
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
    },
  },
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        local columns = vim.api.nvim_get_option_value("columns", {})

        require("dapui").setup({
          layouts = {
            {
              elements = { "scopes", "watches", "stacks", "breakpoints" },
              size = math.floor((columns / (columns >= 160 and 3 or 2)) / 2),
              position = "left",
            },
            { elements = { "console", "repl" }, size = 0.25, position = "bottom" },
          },
        })
      end,
    },
    {
      "rcarriga/cmp-dap",
      config = function()
        require("cmp").setup.filetype({
          "dap-repl",
          "dapui_watches",
          "dapui_hover",
        }, { sources = { { name = "dap", keyword_length = 1 } } })
      end,
    },
    {
      "jayp0521/mason-nvim-dap.nvim",
      config = function()
        require("mason-nvim-dap").setup({ ensure_installed = { "firefox", "node2" } })
      end,
    },
  },
  config = function()
    local get_package = require("mason-registry").get_package

    require("dap").adapters.node2 = {
      type = "executable",
      command = "node",
      args = {
        get_package("node-debug2-adapter"):get_install_path() .. "/out/src/nodeDebug.js",
      },
    }

    require("dap").adapters.firefox = {
      type = "executable",
      command = "node",
      args = {
        get_package("firefox-debug-adapter"):get_install_path() .. "/dist/adapter.bundle.js",
      },
    }

    for _, language in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
      require("dap").configurations[language] = {
        {
          name = "Launch Node against current file",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.loop.cwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
        {
          name = "Launch Firefox against localhost",
          request = "launch",
          type = "firefox",
          reAttach = true,
          url = "http://localhost:8080",
          webRoot = "${workspaceFolder}",
          console = "integratedTerminal",
        },
      }
    end

    local call_function = vim.api.nvim_call_function

    call_function(
      "sign_define",
      { "DapBreakpoint", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" } }
    )

    call_function(
      "sign_define",
      { "DapBreakpointCondition", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" } }
    )

    call_function(
      "sign_define",
      { "DapLogPoint", { linehl = "", text = "", texthl = "GitSignsDelete", numhl = "" } }
    )

    call_function(
      "sign_define",
      { "DapStopped", { linehl = "GitSignsChangeLn", text = "", texthl = "GitSignsChange", numhl = "" } }
    )

    call_function("sign_define", { "DapBreakpointRejected", { linehl = "", text = "", texthl = "", numhl = "" } })

    local set_keymap = vim.api.nvim_set_keymap
    local dapui_close = require("dapui").close
    local repl_close = require("dap").repl.close

    require("dap").listeners.after.event_initialized["dapui_config"] = function()
      local step_into = require("dap").step_into

      set_keymap("n", "<F35>", "", {
        callback = function()
          step_into({ ask_for_targets = true })
        end,
      })

      set_keymap("n", "<F11>", "", {
        callback = function()
          step_into()
        end,
      })

      set_keymap("n", "<F17>", "", {
        callback = function()
          require("dap").terminate(); dapui_close(); repl_close()
        end,
      })

      set_keymap("n", "<F6>", "", {
        callback = function()
          require("dap").pause()
        end,
      })

      set_keymap("n", "<F10>", "", {
        callback = function()
          require("dap").step_over()
        end,
      })

      set_keymap("n", "<F23>", "", {
        callback = function()
          require("dap").step_out()
        end,
      })

      set_keymap("n", "<F41>", "", {
        callback = function()
          require("dap").run_last()
        end,
      })

      require("dapui").open()
    end

    local del_keymap = vim.api.nvim_del_keymap
    local keymaps_del = function()
      del_keymap("n", "<F6>")
      del_keymap("n", "<F10>")
      del_keymap("n", "<F11>")
      del_keymap("n", "<F17>") -- S-F5
      del_keymap("n", "<F23>") -- S-F11
      del_keymap("n", "<F35>") -- C-F11
      del_keymap("n", "<F41>") -- S-C-F5
    end

    require("dap").listeners.before.event_exited["dapui_config"] = function()
      dapui_close()
      repl_close()
      keymaps_del()
    end

    require("dap").listeners.before.event_terminated["dapui_config"] = function()
      dapui_close()
      repl_close()
      keymaps_del()
    end
  end,
}
