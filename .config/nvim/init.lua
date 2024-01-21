vim.cmd([[
    set runtimepath+=~/.vim
    set packpath+=~/.vim
]])
vim.o.signcolumn = "yes"
vim.cmd.source("~/.vimrc")

require('treesitter')
