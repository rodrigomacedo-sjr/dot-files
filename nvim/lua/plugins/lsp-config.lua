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
			ensure_installed = {
				"clangd",
				"ts_ls",
				"html",
				"cssls",
				"emmet_language_server",
				"basedpyright",
				"lua_ls",
				"gopls",
				"jdtls",
			},
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
				map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
				map("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
				map("gr", function()
					vim.lsp.buf.references({ includeDeclaration = false })
				end, "[g]oto [r]eferences")
				map("gi", vim.lsp.buf.implementation, "[g]oto [i]mplementations")

				client.server_capabilities.documentFormattingProvider = true
			end

			local lsp_flags = {
				allow_incremental_sync = true,
				debounce_text_changes = 150,
			}

			-- tiny helper to cut repetition
			local function enable(server, cfg)
				cfg = cfg or {}
				cfg.capabilities = capabilities
				cfg.on_attach = on_attach
				cfg.flags = lsp_flags
				vim.lsp.config(server, cfg) -- merges with defaults from nvim-lspconfig's lsp/<server>.lua
				vim.lsp.enable(server) -- auto-starts when filetype & root markers match
			end

			-- JavaScript / TypeScript
			enable("ts_ls")

			-- HTML / CSS / Emmet
			enable("html")
			enable("cssls")
			enable("emmet_language_server")

			-- Python (basedpyright)
			enable("basedpyright", {
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
			enable("lua_ls")

-- Go (gopls) — robust root_dir and only start on real files
local function gopls_root_dir(arg)
  -- Coerce to a real buffer number
  local bufnr = type(arg) == "number" and arg or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then return nil end
  -- Skip non-file/special buffers (e.g. Oil, nofile, help)
  if vim.bo[bufnr].buftype ~= "" then return nil end

  local fname = vim.api.nvim_buf_get_name(bufnr)
  if fname == "" then return nil end

  -- Start searching from the buffer's directory
  local start = vim.fs.dirname(fname)
  if not start or start == "" then return nil end

  -- Find go.work/go.mod/.git upward from the file's dir
  local hit = vim.fs.find({ "go.work", "go.mod", ".git" }, { path = start, upward = true })[1]
  if not hit then
    return start
  end
  return vim.fs.dirname(hit)
end

vim.lsp.config("gopls", {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = gopls_root_dir,
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      gofumpt = true,      -- formatting
      staticcheck = true,  -- linting
      analyses = {
        unusedparams = true,
        nilness = true,
        shadow = true,
        unreachable = true,
        unusedwrite = true,
      },
    },
  },
})

-- Only enable gopls for Go-ish buffers, and only if it's a real file buffer
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "" then
      -- pass the buffer explicitly so we don't fire on special buffers
      vim.lsp.enable("gopls", ev.buf)
    end
  end,
})


	  -- C/C++ (clangd)
	  enable("clangd", {
		  cmd = { "clangd", "--background-index", "--clang-tidy" },
		  init_options = {
			  clangdFileStatus = true,
			  fallbackFlags = { "--std=c++98" },
		  },
	  })

	  -- Java
	  enable("jdtls", { settings = { java = {} } })
  end,  },
}
