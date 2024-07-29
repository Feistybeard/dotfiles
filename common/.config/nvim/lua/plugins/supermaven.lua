return {
  {
    "supermaven-inc/supermaven-nvim",
    commit = "df3ecf7",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<M-K>",
          clear_suggestion = "<C-]>",
          accept_word = "<M-:>",
        },
      })
    end,
  },
}
