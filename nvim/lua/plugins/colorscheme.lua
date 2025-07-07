return {
  "EdenEast/nightfox.nvim",
  name = "nightfox",
  opts = {
    options = {
      transparent = false,
    },
    groups = {
      all = {
        WinSeparator = { fg = "#ffffff" }, -- ← БІЛИЙ роздільник
        VertSplit = { fg = "#ffffff" }, -- ← (на всяк випадок)
      },
    },
  },
  config = function(_, opts)
    require("nightfox").setup(opts)
    vim.cmd.colorscheme("carbonfox") -- 👈 важливо
  end,
}
