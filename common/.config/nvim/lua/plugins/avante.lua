return {
  {
    "yetone/avante.nvim",
    lazy = true,
    event = "BufRead",
    build = "make",
    opts = {
      provider = "ollama",
      ollama = {
        endpoint = "http://192.168.1.208:11434",
        model = "qwen3:30b-a3b",
        options = {
          temperature = 0,
          num_ctx = 20480,
          -- keep_alive = "500m",
        },
      },
      -- provider = "deepseek",
      -- vendors = {
      --   deepseek = {
      --     __inherited_from = "openai",
      --     api_key_name = "DEEPSEEK_API_KEY",
      --     endpoint = "https://api.deepseek.com",
      --     model = "deepseek-coder",
      --   },
      -- },
      hints = { enabled = false },
      file_selector = {
        provider = "snacks",
      },
      windows = {
        sidebar_header = {
          align = "right", -- left, center, right for title
          rounded = false,
        },
      },
      mappings = {
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
          remove_file = "d",
          add_file = "@",
          close = { "<Esc>", "q" },
          close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
        },
      },
    },

    dependencies = {
      {
        "MeanderingProgrammer/render-markdown.nvim",
        lazy = true,
        ft = { "Avante" },
      },
    },
  },
  {
    "stevearc/dressing.nvim",
    lazy = true,
    opts = {
      input = { enabled = false },
      select = { enabled = false },
    },
  },
  {
    "saghen/blink.compat",
    lazy = true,
    opts = {},
    config = function()
      -- monkeypatch cmp.ConfirmBehavior for Avante
      require("cmp").ConfirmBehavior = {
        Insert = "insert",
        Replace = "replace",
      }
    end,
  },
  {
    "saghen/blink.cmp",
    lazy = true,
    opts = {
      sources = {
        compat = { "avante_commands", "avante_mentions", "avante_files" },
      },
    },
  },
}
