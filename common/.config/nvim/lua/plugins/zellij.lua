return {
  {
    "https://github.com/fresh2dev/zellij.vim.git",
    lazy = false,
    keys = {
      { "<leader>tt", ":ZellijNewPane<CR>", mode = { "n" }, { noremap = true } },
      { "<M-f>", ":ZellijNewPane<CR>", mode = { "n", "i" }, { noremap = true } },
      { "<M-t>", ":ZellijNewPaneSplit<CR>", mode = { "n", "i" }, { noremap = true } },
      { "<M-v>", ":ZellijNewPaneVSplit<CR>", mode = { "n", "i" }, { noremap = true } },
    },
  },
}
