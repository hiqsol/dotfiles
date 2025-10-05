return {
  {
    "saghen/blink.cmp",
    config = function()
      local blink = require("blink.cmp")
      blink.setup({
        keymap = {
          preset = "super-tab", -- або "default"
        },
        sources = {
          default = { "lsp", "path", "buffer" },
        },
      })
    end,
  },
}
