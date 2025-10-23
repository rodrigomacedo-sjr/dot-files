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
      local lspconfig = require("lspconfig")
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
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- HTML
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Emmet
      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
      })

      -- Python (basedpyright)
      lspconfig.basedpyright.setup({
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
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Go
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- C/C++ (clangd)
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        cmd = { "clangd", "--background-index", "--clang-tidy" },
        init_options = {
          clangdFileStatus = true,
          fallbackFlags = { "--std=c++98" }, 
        },
        flags = lsp_flags,
      })

      -- Java
      lspconfig.jdtls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = lsp_flags,
        settings = { java = {} },
      })
    end,
  },
}

