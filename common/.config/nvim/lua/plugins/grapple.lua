return {
  {
    "cbochs/grapple.nvim",
    opts = {
      scope = "git",
      icons = true,
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
      { "<leader>m", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
      {
        "<leader>M",
        "<cmd>Grapple toggle_tags<cr>",
        desc = "Grapple open tags window",
      },
      {
        "<leader>1",
        "<cmd>Grapple select index=1<cr>",
        desc = "Select first tag",
      },
      {
        "<leader>2",
        "<cmd>Grapple select index=2<cr>",
        desc = "Select second tag",
      },
      {
        "<leader>3",
        "<cmd>Grapple select index=3<cr>",
        desc = "Select third tag",
      },
      {
        "<leader>4",
        "<cmd>Grapple select index=4<cr>",
        desc = "Select fourth tag",
      },
    },
  },
  {
    "will-lynas/grapple-line.nvim",
    dependencies = {
      "cbochs/grapple.nvim",
      opts = {
        number_of_files = 4,
        mode = "unique_filename",
        -- colors = {
        --   active = "",
        --   inactive = "",
        -- },
      },
    },
  },
}
