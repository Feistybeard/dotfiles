local lspconfig = require("lspconfig")
local map = vim.keymap.set

--  GDScript (Godot)
lspconfig.gdscript.setup({
  cmd = { "nc", "localhost", "6005" }, -- Connect to Godot's language server
  filetypes = { "gd", "gdscript", "gdscript3" },
  root_dir = lspconfig.util.root_pattern("project.godot"),
  on_attach = function(_, bufNr)
    map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", silent = true, buffer = bufNr })
  end,
})

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- virtual_text = false,
      },
    },
  },
}
