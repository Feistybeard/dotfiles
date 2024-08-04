return {
  "echasnovski/mini.files",
  keys = {
    {
      "<leader>e",
      function()
        if not MiniFiles.close() then
          MiniFiles.open()
        end
      end,
      desc = "Open mini.files (directory of current file)",
    },
    {
      "<leader>E",
      function()
        require("mini.files").open(vim.loop.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
    {
      "<leader>fm",
      function()
        require("mini.files").open(LazyVim.root(), true)
      end,
      desc = "Open mini.files (root)",
    },
  },
  opts = {
    mappings = {
      go_in = "L",
      go_out = "H",
      go_in_plus = "",
      go_out_plus = "",
      close = "<Esc>",
    },
    windows = {
      width_nofocus = 20,
      width_focus = 50,
      width_preview = 100,
    },
    options = {
      use_as_default_explorer = true,
    },
  },
}
