vim.g.cpp_std = vim.g.cpp_std or "c++98"

local function set_cpp(std)
  vim.g.cpp_std = std
  vim.notify("C++ standard set to " .. std .. " — restarting clangd", vim.log.levels.INFO)
  -- Neovim 0.11 supports targeting a specific server here:
  pcall(vim.cmd, "LspRestart clangd")
end

vim.api.nvim_create_user_command("Cpp98", function() set_cpp("c++98") end, {})
vim.api.nvim_create_user_command("Cpp11", function() set_cpp("c++11") end, {})
vim.api.nvim_create_user_command("Cpp14", function() set_cpp("c++14") end, {})
vim.api.nvim_create_user_command("Cpp17", function() set_cpp("c++17") end, {})
vim.api.nvim_create_user_command("Cpp20", function() set_cpp("c++20") end, {})
vim.api.nvim_create_user_command("Cpp23", function() set_cpp("c++23") end, {})

return {}

