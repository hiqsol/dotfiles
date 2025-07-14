-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-S>", ":wall<CR>", { desc = "Save all files" })
vim.keymap.set("i", "<C-S>", "<Esc>:wall<CR>", { desc = "Save all files" })
vim.keymap.set("n", "<C-X>", "ZZ", { desc = "Save and close" })

vim.keymap.set({ "n", "i" }, "<C-g><C-r>", "<cmd>GpRewrite<cr>", { desc = "Inline Rewrite" })
vim.keymap.set({ "n", "i" }, "<C-g><C-g>", "<cmd>GpAppend<cr>", { desc = "Append (after)" })
vim.keymap.set({ "n", "i" }, "<C-g><C-b>", "<cmd>GpPrepend<cr>", { desc = "Prepend (before)" })

vim.keymap.set("v", "<C-g><C-r>", ":<C-u>'<,'>GpRewrite<cr>", { desc = "Visual Rewrite" })
vim.keymap.set("v", "<C-g><C-g>", ":<C-u>'<,'>GpAppend<cr>", { desc = "Visual Append (after)" })
vim.keymap.set("v", "<C-g><C-b>", "<Cmd>'<,'>GpPrepend<CR>", { desc = "Visual Prepend (before)" })
vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpImplement<cr>", { desc = "Implement selection" })
