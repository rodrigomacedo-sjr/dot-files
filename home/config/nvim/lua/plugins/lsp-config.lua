return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
      ensure_installed = { "clangd", "ts_ls", "html", "cssls", "emmet_language_server", "basedpyright", "lua_ls", "gopls", "jdtls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        map("gd", vim.lsp.buf.definition,      "[g]oto [d]efinition")
        map("gD", vim.lsp.buf.declaration,     "[g]oto [D]eclaration")
        map("gr", function() vim.lsp.buf.references({ includeDeclaration = false }) end, "[g]oto [r]eferences")
        map("gi", vim.lsp.buf.implementation,  "[g]oto [i]mplementations")

        client.server_capabilities.documentFormattingProvider = true
      end

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      -- JavaScript / TypeScript
      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- HTML
      vim.lsp.config("html", {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- CSS
      vim.lsp.config("cssls", {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Emmet
      vim.lsp.config("emmet_language_server", {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Python (basedpyright)
      vim.lsp.config("basedpyright", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- Lua
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Go
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- C/C++ (clangd)
      vim.lsp.config("clangd", {
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        init_options = {
          clangdFileStatus = true,
          fallbackFlags = { "--std=c++23" }, 
        },
        flags = lsp_flags,
      })

      -- Java
      vim.lsp.config("jdtls", {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        settings = { java = {} },
      })
    end,
  },
}

