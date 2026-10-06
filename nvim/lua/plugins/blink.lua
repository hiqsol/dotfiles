-- blink.cmp is LazyVim's default completion engine; these opts are merged
-- with LazyVim's defaults (sources lsp/path/snippets/buffer already included)
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "super-tab", -- або "default"
      },
    },
  },
}
