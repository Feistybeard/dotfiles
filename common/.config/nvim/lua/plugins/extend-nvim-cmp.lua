return {
  "hrsh7th/nvim-cmp",
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")

    opts.mapping = vim.tbl_extend("force", opts.mapping, {
      ["<C-l>"] = cmp.mapping.confirm({ select = true }),
      ["<C-h>"] = cmp.mapping.abort(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-u"] = cmp.mapping.scroll_docs(-4),
      ["<C-d"] = cmp.mapping.scroll_docs(4),
      -- ["<CR>"] = function(fallback)
      --   cmp.abort()
      --   fallback()
      -- end,
    })
  end,
}
