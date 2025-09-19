return {
  { "scottmckendry/cyberdream.nvim", colors = { bg = "#000000" } },
  { "EdenEast/nightfox.nvim" }, -- carbonfox (pure black)
  { "ellisonleao/gruvbox.nvim" }, -- gruvbox-material-black
  { "folke/tokyonight.nvim" }, -- tokyonight-moon (blackish)
  { "Mofiqul/dracula.nvim" }, -- dracula with black variant
  { "nyoom-engineering/oxocarbon.nvim" }, -- oxocarbon dark
  { "catppuccin/nvim", name = "catppuccin" }, -- mocha black
  { "rebelot/kanagawa.nvim" }, -- kanagawa-dragon (black)
  { "projekt0n/github-nvim-theme" }, -- github_dark_default (black bg)
  { "lunarvim/darkplus.nvim" }, -- vscode dark+ black
  { "tanvirtin/monokai.nvim" },
  { "tjdevries/colorbuddy.nvim" }, -- dependency for some (optional)

  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        themes = {
          "default",
          "cyberdream",
          "carbonfox",
          "oxocarbon",
          "github_dark_default",
          "tokyonight-moon",
          "dracula",
          "catppuccin-mocha",
          "kanagawa-dragon",
          "darkplus",
          "habamax",
          "gruvbox-material-black",
          "monokai",
        },
        livePreview = true,
      })
      -- хоткей для виклику меню
      vim.keymap.set("n", "<leader>tc", ":Themery<CR>", { noremap = true, silent = true })
    end,
  },
}
