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

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")

-- Buffer-related mappings
vim.keymap.set("n", "<leader>bo", ":BufferCloseAllButCurrent<CR>", { silent = true, desc = "Close other buffers" })
vim.keymap.set("n", "<leader>bx", ":bd<CR>", { silent = true, desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bn", ":enew<CR>", { noremap = true, silent = true, desc = "New Buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { silent = true, desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<leader>br", ":edit<CR>", { silent = true, desc = "Reload buffer" })
vim.keymap.set("n", "<leader>bs", ":w<CR>", { silent = true, desc = "Save buffer" })
vim.keymap.set("n", "<leader>ba", ":wa<CR>", { silent = true, desc = "Save all buffers" })
vim.keymap.set("n", "<leader>bd", ":bp|bd #<CR>", { silent = true, desc = "Delete buffer without closing window" })

-- Neotree specific mapping
vim.keymap.set("n", "<S-CR>", ":Neotree action=open_split<CR>", { silent = true, desc = "Open file in a new buffer" })

-- Window-related mappings
vim.keymap.set("n", "<leader>wh", "<C-w>s", { silent = true, desc = "New window horizontally" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { silent = true, desc = "New window vertically" })
vim.keymap.set("n", "<leader>wx", "<C-w>c", { silent = true, desc = "Close current window" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { silent = true, desc = "Close all other windows" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { silent = true, desc = "Equalize window sizes" })
vim.keymap.set("n", "<leader>wm", "<C-w>_<CR>", { silent = true, desc = "Maximize current window" })

-- Clipboard stuff
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selection to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+yg_', { desc = "Copy current line to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>yy", '"+yy', { desc = "Copy entire line to system clipboard" })

-- Web stuff
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  pattern = "*.html,*.js,*.css",
  callback = function()
    vim.cmd("silent! write")
  end,
})
vim.keymap.set("n", "<leader>p", ":!xdg-open %<CR>", { silent = true })

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
