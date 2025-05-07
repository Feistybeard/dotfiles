return {
  "echasnovski/mini.files",
  -- keys = {
  --   {
  --     "<leader>fm",
  --     function()
  --       if not MiniFiles.close() then
  --         MiniFiles.open()
  --       end
  --     end,
  --     desc = "Open mini.files (directory of current file)",
  --   },
  --   {
  --     "<leader>fM",
  --     function()
  --       require("mini.files").open(vim.loop.cwd(), true)
  --     end,
  --     desc = "Open mini.files (cwd)",
  --   },
  -- },
  opts = {
    mappings = {
      close = "q",
    },
    windows = {
      preview = true,
      width_focus = 60,
      width_preview = 60,
    },
    -- windows = {
    --   -- width_nofocus = 20,
    --   -- width_focus = 50,
    --   -- width_preview = 100,
    -- },
    -- windows = {
    --   preview = true,
    --   width_focus = 30,
    --   width_preview = 30,
    -- },
    options = {
      use_as_default_explorer = true,
      permanent_delete = false,
    },
  },
}
