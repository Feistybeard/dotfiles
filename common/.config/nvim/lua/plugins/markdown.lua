return {
  {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "echasnovski/mini.icons",
    },
    config = function()
      require("render-markdown").setup({
        pipe_table = {
          border = {
            "╭",
            "┬",
            "╮",
            "├",
            "┼",
            "┤",
            "╰",
            "┴",
            "╯",
            "│",
            "─",
          },
        },
      })
    end,
  },
}
