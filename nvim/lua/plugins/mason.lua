return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "lua-language-server",
      "pyright",
      "tsserver",
      "stylua",
      "flake8",
      "shellcheck",
    },
  },
}