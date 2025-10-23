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

				buf_set_keymap("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts)
				buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
				buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				buf_set_keymap("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
				buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
				buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
				buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
				buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
				buf_set_keymap("n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", opts)
				client.server_capabilities.document_formatting = true
			end

			local lsp_flags = {
				allow_incremental_sync = true,
				debounce_text_changes = 150,
			}
			local lspconfig = require("lspconfig")

			-- JavaScript / TypeScript support
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})

			-- HTML support
			lspconfig.html.setup({
				capabilities = capabilities,
			})

			-- CSS support
			lspconfig.cssls.setup({
				capabilities = capabilities,
			})

			-- Emmet
			lspconfig.emmet_ls.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
			})

			-- Python support (Django and FastAPI too)
			lspconfig.basedpyright.setup({
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
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			-- Golang support using gopls
			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			-- C++ support using clangd
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = { "clangd", "--background-index", "--clang-tidy" },
				init_options = {
					clangdFileStatus = true,
					fallbackFlags = { "--std=c++20" },
				},
			})

			-- Java
			lspconfig.jdtls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				flags = lsp_flags,
				-- cmd = { "jdtls", "-data", "/path/to/your/workspace" },
				settings = {
					java = {},
				},
			})

			-- Common LSP key mappings
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, desc = "Hover (LSP)" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, desc = "Go to definition" })
			vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, desc = "See references" })
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "Code action" })
		end,
	},
}
