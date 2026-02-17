return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "bash",
        "python",
        "typescript",
        "javascript",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "regex",
        "toml",
      },
      indent = { enable = true },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = { mode = "cursor", max_lines = 3 },
  },
}
