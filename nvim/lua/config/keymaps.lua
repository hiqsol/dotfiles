-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Git Diff (buffer)" })
vim.keymap.set("n", "<leader>gB", "<cmd>Gitsigns blame<CR>", { desc = "Git Blame (buffer)" })
vim.keymap.set("n", "<leader>gD", function()
  Snacks.picker.git_diff()
end, { desc = "Git Diff (hunks)" })
vim.keymap.set({ "n", "x" }, "<leader>go", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })

vim.keymap.set("n", "<C-C>", "gcc", { desc = "Comment line", remap = true })
vim.keymap.set("x", "<C-C>", "gc", { desc = "Comment selection", remap = true })

vim.keymap.set("n", "<C-S>", ":wall<CR>", { desc = "Save all files" })
vim.keymap.set("i", "<C-S>", "<Esc>:wall<CR>", { desc = "Save all files" })
vim.keymap.set("n", "<C-X>", "ZZ", { desc = "Save and close" })

vim.keymap.set("n", "<leader>ip", function()
  vim.api.nvim_put({ vim.fn.expand("%:p") }, "l", true, true)
end, { desc = "Insert full path below" })

vim.keymap.set({ "n", "i" }, "<C-g><C-r>", "<cmd>GpRewrite<cr>", { desc = "Inline Rewrite" })
vim.keymap.set({ "n", "i" }, "<C-g><C-g>", "<cmd>GpAppend<cr>", { desc = "Append (after)" })
vim.keymap.set({ "n", "i" }, "<C-g><C-b>", "<cmd>GpPrepend<cr>", { desc = "Prepend (before)" })

vim.keymap.set("v", "<C-g><C-r>", ":<C-u>'<,'>GpRewrite<cr>", { desc = "Visual Rewrite" })
vim.keymap.set("v", "<C-g><C-g>", ":<C-u>'<,'>GpAppend<cr>", { desc = "Visual Append (after)" })
vim.keymap.set("v", "<C-g><C-b>", "<Cmd>'<,'>GpPrepend<CR>", { desc = "Visual Prepend (before)" })
vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpImplement<cr>", { desc = "Implement selection" })
