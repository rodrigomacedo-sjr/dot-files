vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false
vim.opt.number = true         -- Enable absolute line numbers
vim.opt.relativenumber = true -- Enable relative numbers for non-cursor lines

vim.wo.relativenumber = true

-- Web stuff
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*.html,*.js,*.css",
  callback = function()
    vim.cmd("silent! write")
  end,
})

-- Go specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.expandtab = false
  end,
})

--[[
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    vim.cmd("silent! !gofmt -w %")
    vim.cmd("edit!")
  end,
})
]]
