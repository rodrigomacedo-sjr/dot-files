-- Navigation
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- Search
vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>", { desc = "clear searc[h]" })

-- Buffer-related
vim.keymap.set("n", "<leader>bo", ":BufferLineCloseOthers<CR>", { silent = true, desc = "[b]uffers, close [o]thers" })
vim.keymap.set("n", "<leader>bx", ":bd<CR>", { silent = true, desc = "current [b]uffer, e[x]clude" })
vim.keymap.set("n", "<leader>bc", ":enew<CR>", { noremap = true, silent = true, desc = "[b]uffer, [c]reate" })
vim.keymap.set("n", "<leader>br", ":edit<CR>", { silent = true, desc = "[b]uffer [r]eload" })
vim.keymap.set("n", "<leader>bs", ":w<CR>", { silent = true, desc = "[b]uffer [s]ave" })
vim.keymap.set("n", "<leader>ba", ":wa<CR>", { silent = true, desc = "[b]uffer save [a]ll" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { silent = true, desc = "[b]uffer, [p]revious" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { silent = true, desc = "[b]uffer [n]ext" })
vim.keymap.set("n", "<leader>bb", ":BufferLinePick<CR>", { silent = true, desc = "[b]uffer [b]rowser" })
vim.keymap.set(
  "n",
  "<leader>bR",
  ":BufferLineCloseRight<CR>",
  { silent = true, desc = "[b]uffers, close to the [R]ight" }
)
vim.keymap.set(
  "n",
  "<leader>bL",
  ":BufferLineCloseLeft<CR>",
  { silent = true, desc = "[b]uffers, close to the [L]eft" }
)
vim.keymap.set({ "n", "i" }, "<C-Tab>", ":bnext<CR>", { silent = true, desc = "next buffer" })
vim.keymap.set({ "n", "i" }, "<C-S-Tab>", ":bprevious<CR>", { silent = true, desc = "previous buffer" })
vim.keymap.set(
  "n",
  "<leader>bf",
  ":Neotree buffers reveal float<CR>",
  { silent = true, desc = "reveal [b]uffers in [f]loating window" }
)
vim.keymap.set("n", "<S-CR>", ":Neotree action=open_split<CR>", { silent = true, desc = "open file in a new buffer" })

-- Window-related
vim.keymap.set("n", "<leader>wh", "<C-w>s", { silent = true, desc = "new [w]indow [h]orizontally" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { silent = true, desc = "new [w]indow [v]ertically" })
vim.keymap.set("n", "<leader>wx", "<C-w>c", { silent = true, desc = "[w]indow e[x]terminate" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { silent = true, desc = "[w]indows, close all [o]thers" })
vim.keymap.set("n", "<leader>we", "<C-w>=", { silent = true, desc = "make [w]indow sizes [e]qual" })
vim.keymap.set("n", "<leader>wm", "<C-w>_<CR>", { silent = true, desc = "[w]indow, [m]aximize" })

-- Clipboard stuff
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[y]ank selection to system" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "[y]ank to system" })
vim.keymap.set("n", "<leader>Y", '"+yy', { desc = "[Y]ank line to system" })

-- File opening
vim.keymap.set("n", "<leader>p", ":!xdg-open %<CR>", { silent = true, desc = "o[p]en file" })
vim.keymap.set("n", "<leader>ls", ":LiveServerStart <CR>", { desc = "[l]ive server [s]tart" })
vim.keymap.set("n", "<leader>lp", ":LiveServerStop <CR>", { desc = "[l]ive server sto[p]" })
vim.keymap.set("n", "<leader>e", ":Neotree filesystem toggle left<CR>", { silent = true, desc = "toggle file tre[e]" })

--[[
-- LSP navigation
vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { silent = true, desc = "[g]oto [d]efinition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "[g]oto [D]eclaration" })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { silent = true, desc = "[g]oto [r]eferences" })
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { silent = true, desc = "[g]oto [i]mplementations" })
--]]

vim.keymap.set("n", "gn", vim.diagnostic.goto_next, { silent = true, desc = "[g]oto [n]ext diagnostic" })
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev, { silent = true, desc = "[g]oto [p]revious diagnostic" })
-- LSP utils
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { silent = true, desc = "[f]or[m]at" })
vim.keymap.set("v", "<leader>fm", vim.lsp.buf.format, { silent = true, desc = "[f]or[m]at" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { silent = true, desc = "[K]now more" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, desc = "[c]ode [a]ction" })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true, desc = "[r]e[n]ame" })
vim.keymap.set("n", "<leader>ll", vim.lsp.codelens.run, { silent = true, desc = "[l]sp code[l]ens" })
-- vim.keymap.set("n", "gh", vim.lsp.buf.hover, { silent = true, desc = "[g]oto [h]over" })

-- Git
vim.keymap.set("n", "<leader>gv", "<cmd>Gitsigns preview_hunk<CR>", { desc = "[g]it [v]iew hunk" })

vim.keymap.set("n", "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", { desc = "[g]it [n]ext hunk" })
vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns prev_hunk<CR>", { desc = "[g]it [p]revious hunk" })

vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "[g]it [r]eset hunk" })
vim.keymap.set("v", "<leader>gr", function()
  require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end, { desc = "[g]it [r]eset selected hunk" })

vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "[g]it toggle line [b]lame" })

-- Tests
vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>", { silent = true, desc = "[t]est [n]earest" })
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>", { silent = true, desc = "[t]est [f]ile" })
vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>", { silent = true, desc = "[t]est [s]uite" })
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>", { silent = true, desc = "[t]est [l]ast" })
vim.keymap.set("n", "<leader>tv", ":TestVisit<CR>", { silent = true, desc = "[t]est [v]isit" })

-- Marks
vim.keymap.set("n", "<leader>ml", ":Telescope marks<CR>", { desc = "[m]arks, [l]ist" })
vim.keymap.set("n", "<leader>md", ":delm ", { desc = "[m]arks, [d]elete" })
vim.keymap.set("n", "<leader>mD", ":delm A-Za-Z0-9<CR>", { desc = "[m]arks, [D]elete all" })

-- Quickfix
vim.keymap.set("n", "<leader>qn", ":cn<CR>", { desc = "[q]uickfix list [n]ext" })
vim.keymap.set("n", "<leader>qp", ":cp<CR>", { desc = "[q]uickfix list [p]revious" })
vim.keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "[q]uickfix window [o]pen" })
vim.keymap.set("n", "<leader>qc", ":close<CR>", { desc = "[q]uickfix window [c]lose" })
