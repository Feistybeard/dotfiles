return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          use_treesitter = true,
          textobject = "ic",
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "╭",
            left_bottom = "╰",
            right_arrow = ">",
          },
          style = "#806d9c",
          delay = 0,
        },
        indent = {
          enable = true,
          priority = 10,
          -- style = { vim.api.nvim_get_hl(0, { name = "Whitespace" }) },
          style = { "#1c2541" },
          use_treesitter = false,
          chars = { "│" },
          ahead_lines = 5,
          delay = 100,
        },
      })
    end,
  },
}
