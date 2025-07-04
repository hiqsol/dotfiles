return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash", "html", "javascript", "json", "lua",
      "markdown", "python", "typescript", "yaml",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}