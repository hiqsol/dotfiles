return {
  "robitx/gp.nvim",
  config = function()
    require("gp").setup({
      openai_api_key = os.getenv("OPENAI_API_KEY"),
      agents = {
        {
          name = "GPT-4o",
          model = "gpt-4o",
          system_prompt = "Ти помічник для кодування та написання текстів українською та англійською.",
          temperature = 0.7,
        },
      },
      chat_agent = "GPT-4o",
      command_agent = "GPT-4o",
    })
  end,
}
