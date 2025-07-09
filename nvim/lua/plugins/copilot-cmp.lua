return {
  "zbirenbaum/copilot-cmp",
  dependencies = { "copilot.lua" },
  config = function()
    require("copilot_cmp").setup()
  end,
}
