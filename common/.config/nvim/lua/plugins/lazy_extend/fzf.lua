return {
  "ibhagwan/fzf-lua",
  opts = {
    "border-fused",
    defaults = {
      git_icons = false,
      file_icons = false,
      color_icons = false,
      formatter = "path.filename_first",
    },
    winopts = {
      preview = {
        wrap = true,
      },
    },
    previewers = {
      builtin = {
        syntax_limit_b = -102400, -- 100KB limit on highlighting files
      },
    },
  },
}
