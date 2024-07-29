return {
  "nosduco/remote-sshfs.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("remote-sshfs").setup({
      ui = {
        confirm = {
          connect = false,
        },
      },
    })
  end,
}
