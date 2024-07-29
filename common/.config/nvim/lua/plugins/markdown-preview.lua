return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  build = function()
    local install_path = vim.fn.stdpath("data")
      .. "/lazy/markdown-preview.nvim/app"
    vim.cmd("silent !cd " .. install_path .. " && npm install && git restore .")
  end,
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_auto_close = 0
  end,
}
