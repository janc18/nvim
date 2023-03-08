vim.api.nvim_set_option_value("signcolumn", "yes:1", TBL)

local borderstyle = require("wuelnerdotexe.plugin.util").get_border().style

vim.diagnostic.config({
  signs = { priority = require("wuelnerdotexe.plugin.config").signs_priority.diagnostic },
  virtual_text = false,
  virtual_lines = true,
  float = { header = { "Diagnostics", "Title" }, border = borderstyle },
  update_in_insert = true,
  severity_sort = true,
})

local ref_floating_preview = vim.lsp.util.open_floating_preview

vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = borderstyle

  return ref_floating_preview(contents, syntax, opts, ...)
end

return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "b0o/schemastore.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
          require("mason-lspconfig").setup({
            ensure_installed = {
              "bashls",
              "cssls",
              "docker_compose_language_service",
              "dockerls",
              "eslint",
              "html",
              "jsonls",
              "tailwindcss",
              "tsserver",
              "yamlls",
            },
          })
        end,
      },
    },
    config = function()
      require("lspconfig.ui.windows").default_options.border = borderstyle

      local on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.attach")(client, bufnr) end
      local capabilities = { textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } } }
      local flags = { debounce_text_changes = 284 }

      local ok_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

      if ok_cmp_nvim_lsp then vim.tbl_deep_extend("keep", capabilities, cmp_nvim_lsp.default_capabilities()) end

      require("lspconfig").eslint.setup({
        on_attach = on_attach,
        flags = flags,
        capabilities = capabilities,
        settings = { format = false },
      })

      require("lspconfig").html.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = flags,
        init_options = { provideFormatter = false },
      })

      require("lspconfig").jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = flags,
        init_options = { provideFormatter = false },
        settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } },
      })

      require("lspconfig").yamlls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = flags,
        settings = { yaml = { schemas = require("schemastore").json.schemas() } },
      })

      local validate = { validate = false }

      require("lspconfig").cssls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = flags,
        settings = { css = validate, less = validate, scss = validate },
      })

      local basic_setup = { on_attach = on_attach, capabilities = capabilities, flags = flags }

      require("lspconfig").bashls.setup(basic_setup)
      require("lspconfig").dockerls.setup(basic_setup)
      require("lspconfig").docker_compose_language_service.setup(basic_setup)
      require("lspconfig").tsserver.setup(basic_setup)
      require("lspconfig").tailwindcss.setup(basic_setup)
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
      {
        "jay-babu/mason-null-ls.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
          require("mason-null-ls").setup({
            ensure_installed = {
              "actionlint",
              "hadolint",
              "jsonlint",
              "markdownlint",
              "prettierd",
              "shfmt",
              "yamllint",
            },
          })
        end,
      },
    },
    config = function()
      require("null-ls").setup({
        border = borderstyle,
        update_in_insert = true,
        debounce = 284,
        on_attach = function(client, bufnr) require("wuelnerdotexe.plugin.start.lsp.attach")(client, bufnr) end,
        sources = {
          require("null-ls").builtins.diagnostics.markdownlint,
          require("null-ls").builtins.diagnostics.hadolint,
          require("null-ls").builtins.diagnostics.jsonlint,
          require("null-ls").builtins.diagnostics.yamllint,
          require("null-ls").builtins.diagnostics.actionlint,
          require("null-ls").builtins.formatting.shfmt,
          require("null-ls").builtins.formatting.prettierd.with({
            condition = function(utils)
              local config_files = require("lspconfig.util").insert_package_json({
                ".prettierrc",
                ".prettierrc.json",
                ".prettierrc.yml",
                ".prettierrc.yaml",
                ".prettierrc.json5",
                ".prettierrc.js",
                ".prettierrc.cjs",
                ".prettierrc.toml",
                "prettier.config.js",
                "prettier.config.cjs",
              }, "prettier")

              return utils.has_file(config_files) or utils.root_has_file(config_files)
            end,
          }),
        },
      })
    end,
  },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    config = function()
      require("nvim-lightbulb").setup({
        sign = { priority = require("wuelnerdotexe.plugin.config").signs_priority.lightbulb },
        autocmd = { enabled = true },
      })

      vim.api.nvim_call_function(
        "sign_define",
        { "LightBulbSign", { text = "", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" } }
      )
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "LspAttach",
    config = function()
      require("lsp_lines").setup()

      vim.api.nvim_set_keymap("n", "<leader>lt", "", { callback = function() require("lsp_lines").toggle() end })
    end,
  },
}
