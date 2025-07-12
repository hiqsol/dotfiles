-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-S>", ":wall<CR>", { desc = "Save all files" })
vim.keymap.set("i", "<C-S>", "<Esc>:wall<CR>", { desc = "Save all files" })
vim.keymap.set("n", "<C-X>", "ZZ", { desc = "Save and close" })
