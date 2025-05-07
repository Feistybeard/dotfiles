return {
  "saghen/blink.cmp",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      menu = {
        border = "single",
        draw = {
          columns = {
            { "label", gap = 10 },
            { "kind_icon", gap = 1 },
            { "kind" },
            { "label_description" },
          },
          gap = 1,
          treesitter = { "lsp" },
        },
      },
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "single",
        },
      },
      ghost_text = {
        enabled = true,
      },
    },
    signature = { enabled = false, window = { border = "single" } },
    -- sources = {
    --   default = { "snippets", "lsp", "path", "buffer" },
    --   providers = {
    --     snippets = {
    --       min_keyword_length = 1,
    --       score_offset = 4,
    --     },
    --     lsp = {
    --       min_keyword_length = 0,
    --       score_offset = 3,
    --       name = "LSP",
    --       module = "blink.cmp.sources.lsp",
    --       fallbacks = {},
    --     },
    --     path = {
    --       min_keyword_length = 0,
    --       score_offset = 2,
    --     },
    --     buffer = {
    --       min_keyword_length = 1,
    --       score_offset = 1,
    --     },
    --   },
    -- },
    cmdline = {
      enabled = true,
      ---@diagnostic disable-next-line: assign-type-mismatch
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- Commands
        if type == ":" or type == "@" then
          return { "cmdline" }
        end
        return {}
      end,
      completion = {
        menu = {
          auto_show = true,
          draw = {
            columns = { { "kind_icon", "label", "label_description", gap = 1 } },
          },
        },
      },
    },
    appearance = {
      kind_icons = {
        Text = "󰉿",
        Method = "",
        Function = "󰊕",
        Constructor = "󰒓",
        Field = "",
        Variable = "󰆦",
        Property = "󰖷",
        Class = "",
        Interface = "",
        Struct = "󱡠",
        Module = "󰅩",
        Unit = "󰪚",
        Value = "",
        Enum = "",
        EnumMember = "",
        Keyword = "",
        Constant = "󰏿",
        Snippet = "",
        Color = "󰏘",
        File = "󰈔",
        Reference = "󰬲",
        Folder = "󰉋",
        Event = "󱐋",
        Operator = "󰪚",
        TypeParameter = "󰬛",
        Error = "󰏭",
        Warning = "",
        Information = "󰋼",
        Hint = "",
      },
    },
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide" },
      ["<Esc>"] = { "cancel" },
      ["<C-y>"] = { "select_and_accept" },
      ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
      ["<C-j>"] = { "select_next", "fallback_to_mappings" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
    },
  },
}
