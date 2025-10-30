return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "go", "gomod", "gowork", "gotmpl" },
  build = ':lua require("go.install").update_all_sync()',
  config = function()
    require("go").setup({})

    local grp = vim.api.nvim_create_augroup("GoImportOnSave", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = grp,
      pattern = "*.go",
      callback = function()
        require("go.format").goimports()
      end,
    })
  end,
}

