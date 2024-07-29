return {
  "chrisgrieser/nvim-spider",
  keys = {
    {
      "w",
      "<cmd>lua require('').motion('w')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to end of word",
    },
    {
      "e",
      "<cmd>lua require('spider').motion('e')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of next word",
    },
    {
      "b",
      "<cmd>lua require('spider').motion('b')<CR>",
      mode = { "n", "o", "x" },
      desc = "Move to start of previous word",
    },
  },
}
