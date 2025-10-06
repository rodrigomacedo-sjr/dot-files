return {
  "olrtg/nvim-emmet",
  ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
  config = function()
    -- Map the function for wrapping with abbreviation in both normal and visual modes.
    vim.keymap.set(
      { "n", "v" },
      "<leader>a",
      require("nvim-emmet").wrap_with_abbreviation,
      { desc = "wrap with emmet [a]bbreviation" }
    )
  end,
}
