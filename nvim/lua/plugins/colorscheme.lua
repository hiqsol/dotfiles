return {
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        options = {
          transparent = false,
        },
      })
      vim.cmd("colorscheme carbonfox")
    end,
  },
}
