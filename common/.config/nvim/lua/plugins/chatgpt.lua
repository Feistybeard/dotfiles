return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>a", "", desc = "ai", mode = { "n", "v" } },
      {
        "<leader>aa",
        "<cmd>ChatGPT<CR>",
        desc = "ChatGPT",
        mode = { "n", "v" },
      },
      {
        "<leader>ar",
        "<cmd>ChatGPTRun code_readability_analysis<CR>",
        desc = "Code Readability Analysis",
        mode = { "n", "v" },
      },
      {
        "<leader>ae",
        "<cmd>ChatGPTEditWithInstruction<CR>",
        desc = "ChatGPT Edit with Instruction",
        mode = { "n", "v" },
      },
      {
        "<leader>ag",
        "<cmd>ChatGPTRun grammar_correction<CR>",
        desc = "ChatGPT Grammar Correction",
        mode = { "n", "v" },
      },
      {
        "<leader>at",
        "<cmd>ChatGPTRun translate<CR>",
        desc = "ChatGPT Translate",
        mode = { "n", "v" },
      },
      {
        "<leader>ak",
        "<cmd>ChatGPTRun keywords<CR>",
        desc = "ChatGPT Keywords",
        mode = { "n", "v" },
      },
      {
        "<leader>ad",
        "<cmd>ChatGPTRun docstring<CR>",
        desc = "ChatGPT Docstring",
        mode = { "n", "v" },
      },
      {
        "<leader>aj",
        "<cmd>ChatGPTRun add_tests<CR>",
        desc = "ChatGPT Add Tests",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        "<cmd>ChatGPTRun optimize_code<CR>",
        desc = "ChatGPT Optimize Code",
        mode = { "n", "v" },
      },
      {
        "<leader>as",
        "<cmd>ChatGPTRun summarize<CR>",
        desc = "ChatGPT Summarize",
        mode = { "n", "v" },
      },
      {
        "<leader>af",
        "<cmd>ChatGPTRun fix_bugs<CR>",
        desc = "ChatGPT Fix Bugs",
        mode = { "n", "v" },
      },
      {
        "<leader>ax",
        "<cmd>ChatGPTRun explain_code<CR>",
        desc = "ChatGPT Explain Code",
        mode = { "n", "v" },
      },
    },
    config = function()
      require("chatgpt").setup({
        api_host_cmd = "echo http://192.168.1.208:11434",
        api_key_cmd = "echo ''",
        openai_params = {
          model = "mistral-nemo:12b-instruct-2407-q8_0",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        },
        openai_edit_params = {
          model = "mistral-nemo:12b-instruct-2407-q8_0",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 4095,
          temperature = 0.2,
          top_p = 0.1,
          n = 1,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
