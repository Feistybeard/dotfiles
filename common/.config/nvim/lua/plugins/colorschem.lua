return {
  "marko-cerovac/material.nvim",
  opts = {
    contrast = {
      terminal = false, -- Enable contrast for the built-in terminal
      sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
      floating_windows = false, -- Enable contrast for floating windows
      cursor_line = false, -- Enable darker background for the cursor line
      non_current_windows = false, -- Enable contrasted background for non-current windows
      filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
    },

    styles = { -- Give comments style such as bold, italic, underline etc.
      comments = { italic = true },
      functions = { --[[ bold = true, undercurl = true ]]
      },
      variables = {},
      operators = {},
      types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
      -- Available plugins:
      -- "dap",
      "gitsigns",
      "lspsaga",
      "nvim-cmp",
      "nvim-navic",
      "nvim-tree",
    },

    disable = {
      colored_cursor = false, -- Disable the colored cursor
      borders = true, -- Disable borders between verticaly split windows
      -- background = true, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
      -- term_colors = true, -- Prevent the theme from setting terminal colors
      eob_lines = false, -- Hide the end-of-buffer lines
    },

    high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = true, -- Enable higher contrast text for darker style
    },

    lualine_style = "stealth", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_colors = nil, -- If you want to override the default colors, set this to a function

    custom_highlights = {
      -- Pmenu = { bg = "#0F111A" },
      -- PmenuSel = { bg = "#191c28" },
      -- Normal = { bg = "#090b0f" },
      -- NormalNC = { bg = "#090b0f" },
      -- NvimTreeOpenedFolderName = { fg = "#799be5" },
    }, -- Overwrite highlights with your own
  },
}
