return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  build = ":Copilot auth",
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false }, -- ❗ вимикаємо ghost text
      panel = { enabled = false },
    })
  end,
}
