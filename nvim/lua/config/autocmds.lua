-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- White window separator; re-apply after every colorscheme change
local function set_win_separator()
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ffffff" }) -- white
end
set_win_separator()
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("user_win_separator", { clear = true }),
  callback = set_win_separator,
})
