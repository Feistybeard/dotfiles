return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-l>"] = cmp.mapping.confirm({ select = true }),
      ["<C-h>"] = cmp.mapping.abort(),
      ["<C-j>"] = cmp.mapping(
        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        { "i", "c" }
      ),
      ["<C-k>"] = cmp.mapping(
        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        { "i", "c" }
      ),
      ["<C-u"] = cmp.mapping.scroll_docs(-4),
      ["<C-d"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ["<C-y>"] = cmp.mapping(
        cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        { "i", "c" }
      ),
      -- ["<CR>"] = function(fallback)
      --   cmp.abort()
      --   fallback()
      -- end,
    })
    cmp.setup({
      window = {
        completion = {
          border = {
            { "󱐋", "WarningMsg" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          scrollbar = false,
        },
        documentation = {
          border = {
            { "", "DiagnosticHint" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
          scrollbar = false,
        },
      },
    })
    require("luasnip.loaders.from_vscode").lazy_load()
    local max_items = 5
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer", max_item_count = max_items },
      },
    })
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path", max_item_count = max_items },
      }, {
        { name = "cmdline", max_item_count = max_items },
      }),
    })
  end,
}
