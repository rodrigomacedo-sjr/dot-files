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
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local on_attach = function(client, bufnr)
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end
				local function buf_set_option(...)
					vim.api.nvim_buf_set_option(bufnr, ...)
				end

				buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
				local opts = { noremap = true, silent = true }

				client.server_capabilities.document_formatting = true
			end

			local lsp_flags = {
				allow_incremental_sync = true,
				debounce_text_changes = 150,
			}
      local lspconfig = require("lspconfig")

			-- JavaScript / TypeScript support
      vim.lsp.config('ts_ls', {
        capabilities = capabilities
      })

      -- HTML support
      vim.lsp.config('html', {
				capabilities = capabilities,
			})

			-- CSS support
      vim.lsp.config('cssls', {
				capabilities = capabilities,
			})

			-- Emmet
      vim.lsp.config('emmet', {
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
			})

			-- Python support (Django and FastAPI too)
      vim.lsp.config('basedpyright', {
				capabilities = capabilities,
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

			-- Lua support—for your Neovim config etc.
      vim.lsp.config('lua_ls', {
				capabilities = capabilities,
			})

			-- Golang support using gopls
      vim.lsp.config('gopls', {
				capabilities = capabilities,
			})

			-- C++ support using clangd
      vim.lsp.config('clangd', {
				capabilities = capabilities,
				cmd = { "clangd", "--background-index", "--clang-tidy" },
				init_options = {
					clangdFileStatus = true,
					fallbackFlags = { "--std=c++98" },
				},
			})

			-- Java
      vim.lsp.config('jdtls', {
				capabilities = capabilities,
				on_attach = on_attach,
				flags = lsp_flags,
				settings = {
					java = {},
				},
			})

		end,
	},
}
