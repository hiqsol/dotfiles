return {
  "nvim-mini/mini.surround",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.surround").setup({
      mappings = {
        add = "ys", -- keep Tip Pope style
        delete = "ds",
        replace = "cs",
        find = "gsf", -- prefix with `g` to keep normal `s`
        find_left = "gsF",
        highlight = "gsh",
        update_n_lines = "gsn",
      },
    })
  end,
}
