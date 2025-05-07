local utils = require("config.utils")

return {
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>tt", ":CyberdreamToggleMode<CR>", { noremap = true, silent = true })
      require("cyberdream").setup({
        transparent = true,
        variant = "auto",
        italic_comments = true,
        terminal_colors = false,
        cache = true,
        overrides = function(c)
          return {
            CursorLine = { bg = c.bg },
            CursorLineNr = { fg = c.magenta },
          }
        end,
      })
      vim.cmd("colorscheme cyberdream")
    end,
  },
  -- {
  --   "Shatur/neovim-ayu",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("colorscheme ayu")
  --   end,
  -- },
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = {
        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
      },
    },
    config = {
      utils.keymap("n", "<Leader>uo", "<cmd>TransparentToggle<cr>", { desc = "Toggle Transparent" }),
    },
  },
  {
    "shortcuts/no-neck-pain.nvim",
    config = function()
      require("no-neck-pain").setup()
    end,
  },
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = "#303270", guifg = "#a9b1d6" },
            InclineNormalNC = { guibg = "none", guifg = "#a9b1d6" },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = { cursorline = true },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[*]" .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)

          return {
            { icon, guifg = color },
            { " " },
            { filename },
          }
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      -- local copilot_colors = {
      --   [""] = utils.get_hlgroup("Comment"),
      --   ["Normal"] = utils.get_hlgroup("Comment"),
      --   ["Warning"] = utils.get_hlgroup("DiagnosticError"),
      --   ["InProgress"] = utils.get_hlgroup("DiagnosticWarn"),
      -- }

      -- -- Function to get the current mode indicator as a single character
      local function mode()
        -- Map of modes to their respective shorthand indicators
        local mode_map = {
          n = "N", -- Normal mode
          i = "I", -- Insert mode
          v = "V", -- Visual mode
          [""] = "V", -- Visual block mode
          V = "V", -- Visual line mode
          c = "C", -- Command-line mode
          no = "N", -- NInsert mode
          s = "S", -- Select mode
          S = "S", -- Select line mode
          ic = "I", -- Insert mode (completion)
          R = "R", -- Replace mode
          Rv = "R", -- Virtual Replace mode
          cv = "C", -- Command-line mode
          ce = "C", -- Ex mode
          r = "R", -- Prompt mode
          rm = "M", -- More mode
          ["r?"] = "?", -- Confirm mode
          ["!"] = "!", -- Shell mode
          t = "T", -- Terminal mode
        }
        -- Return the mode shorthand or [UNKNOWN] if no match
        return mode_map[vim.fn.mode()] or "[UNKNOWN]"
      end

      return {
        options = {
          component_separators = { left = " ", right = " " },
          section_separators = { left = " ", right = " " },
          -- theme = "16color",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = { mode },
          lualine_b = { { "branch", icon = "" } },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = "󰝶 ",
              },
            },
            { "diff", padding = { left = 0, right = 0 } },
            -- {
            --   "filetype",
            --   icon_only = false,
            --   separator = "",
            --   padding = { left = 0, right = 1 },
            -- },
            -- { "filename", padding = { left = 1, right = 0 } },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
              end,
              color = utils.get_hlgroup("Comment", nil),
            },
            {
              require("grapple-line").lualine,
            },
          },
          lualine_x = {
            {
              color = utils.get_hlgroup("String"),
            },
            -- {
            --   function()
            --     local icon = " "
            --     local status = require("copilot.api").status.data
            --     return icon .. (status.message or "")
            --   end,
            --   cond = function()
            --     local ok, clients =
            --       pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
            --     return ok and #clients > 0
            --   end,
            --   color = function()
            --     if not package.loaded["copilot"] then
            --       return
            --     end
            --     local status = require("copilot.api").status.data
            --     return copilot_colors[status.status] or copilot_colors[""]
            --   end,
            -- },
          },
          lualine_y = {
            {
              "filetype",
              icon_only = false,
              separator = "",
              padding = { left = 1, right = 0 },
            },
            {
              "progress",
            },
            {
              "location",
              color = utils.get_hlgroup("Boolean"),
            },
          },
          lualine_z = {},
        },
        extensions = { "lazy", "toggleterm", "mason", "neo-tree", "trouble" },
      }
    end,
  },
}
