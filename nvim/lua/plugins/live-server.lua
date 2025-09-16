return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = function()
    require("live-server").setup()

    vim.keymap.set("n", "<leader>ls", ":LiveServerStart <CR>", {})
    vim.keymap.set("n", "<leader>lp", ":LiveServerStop <CR>", {})
  end,
}
