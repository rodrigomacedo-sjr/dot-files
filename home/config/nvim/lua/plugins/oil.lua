return {
  "stevearc/oil.nvim",
  config = function()
    local oil = require("oil")
    oil.setup({
      keymaps = {["q"] = ":q<CR>"}
    })
    vim.keymap.set("n", "-", oil.toggle_float, {})
  end,
}
