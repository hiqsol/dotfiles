return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      spelling = {
        enabled = true,
        suggestions = 20,
      },
    },
    window = {
      border = "rounded",
    },
    layout = {
      align = "center",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.register({
      ["<leader>f"] = {
        name = "+file",
        f = { "<cmd>Telescope find_files<CR>", "Find File" },
        r = { "<cmd>Telescope oldfiles<CR>", "Recent Files" },
        s = { "<cmd>w<CR>", "Save File" },
      },
      ["<leader>g"] = { name = "+git" },
      ["<leader>l"] = {
	name = "+lsp/lazy",
        a = { "<cmd>Lazy<CR>", "Open Lazy" },
      },
      ["<leader>c"] = { name = "+code" },
      ["<leader>w"] = {
        name = "+window",
        w = { "<cmd>w<CR>", "Write" },
        q = { "<cmd>q<CR>", "Quit" },
      },
      ["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
    })
  end,
}
