return {
  -- mason
  {
    "williamboman/mason.nvim",
    lazy = false,
    build = ":MasonUpdate",
    config = true,
  },

  -- mason <-> server names
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      automatic_installation = true,
      ensure_installed = {
        -- core
        "gopls",
        "lua_ls",
        "clangd",
        -- web
        "html",
        "cssls",
        "emmet_language_server", -- emmet (modern)
        "tailwindcss",
        "ts_ls",                 -- typescript (tsserver -> ts_ls)
        -- extras you asked for
        "templ",
        "sqls",
      },
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)
    end,
  },

  -- native LSP config (0.11+)
  {
    "neovim/nvim-lspconfig", -- data-only: server defaults, no framework usage
    lazy = false,
    -- make cmp capabilities available early so LSPs pick them up on start
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- capabilities (works with/without nvim-cmp; enhanced if cmp-nvim-lsp is present)
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then capabilities = cmp_lsp.default_capabilities(capabilities) end

      -- shared on_attach (your keymaps kept)
      local function on_attach(client, bufnr)
        local map = function(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end
        map("gd", vim.lsp.buf.definition,        "LSP: Go to Definition")
        map("gD", vim.lsp.buf.declaration,       "LSP: Go to Declaration")
        map("gr", function() vim.lsp.buf.references({ includeDeclaration = false }) end, "LSP: References")
        map("gi", vim.lsp.buf.implementation,    "LSP: Go to Implementation")
        map("K",  vim.lsp.buf.hover,             "LSP: Hover")
        map("<leader>rn", vim.lsp.buf.rename,    "LSP: Rename")
        map("<leader>ca", vim.lsp.buf.code_action,"LSP: Code Action")
        map("<leader>f",  function() vim.lsp.buf.format({ async = false }) end, "LSP: Format Buffer")

        -- format-on-save if server supports it
        if client.supports_method("textDocument/formatting") then
          local grp = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = grp,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 2000 })
            end,
          })
        end

        -- Go: organize imports on save
        if client.name == "gopls" then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              local params = vim.lsp.util.make_range_params()
              params.context = { only = { "source.organizeImports" } }
              local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
              for _, res in pairs(result or {}) do
                for _, r in pairs(res.result or {}) do
                  if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
                  elseif r.command then
                    vim.lsp.buf.execute_command(r.command)
                  end
                end
              end
            end,
          })
        end
      end

      local flags = { debounce_text_changes = 150 }

      -- helper: register + enable with native API
      local function enable(server, cfg)
        cfg = vim.tbl_deep_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
          flags = flags,
        }, cfg or {})
        vim.lsp.config(server, cfg)
        vim.lsp.enable(server)
      end

      -- Go
      enable("gopls", {
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            analyses = {
              unusedparams = true,
              nilness = true,
              unusedwrite = true,
              shadow = true,
            },
            completeUnimported = true,
            usePlaceholders = true,
          },
        },
      })

      -- Lua
      enable("lua_ls", {
        settings = {
          Lua = {
            completion  = { callSnippet = "Replace" },
            diagnostics = { globals = { "vim" } },
            workspace   = { checkThirdParty = false },
            telemetry   = { enable = false },
          },
        },
      })

      -- C/C++
      enable("clangd", {
        cmd = { "clangd", "--background-index", "--clang-tidy" },
      })

      -- SQL
      enable("sqls")

      -- templ (Go HTML components)
      enable("templ")

      -- HTML / HTMX (treat templ as html-ish)
      enable("html", { filetypes = { "html", "templ" } })
      enable("cssls")

      -- Emmet (modern server, templ included upstream)
      enable("emmet_language_server", {
        filetypes = {
          "html", "css", "scss",
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "vue", "svelte", "templ",
        },
      })

      -- Tailwind (recognize `templ` classes)
      enable("tailwindcss", {
        filetypes = {
          "html", "css", "scss",
          "javascript", "javascriptreact",
          "typescript", "typescriptreact",
          "vue", "svelte", "templ",
        },
        init_options = { userLanguages = { templ = "html" } },
      })

      -- JS/TS/React (use ts_ls, not tsserver)
      enable("ts_ls")
    end,
  },
}

