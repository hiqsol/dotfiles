return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup({
      openai_api_key = os.getenv("OPENAI_API_KEY"),
      chat_agent = "ChatGPT-4o",
      command_agent = "ChatGPT-4o",
    })
  end,
}
