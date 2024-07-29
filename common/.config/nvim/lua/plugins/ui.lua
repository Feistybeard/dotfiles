local k = require("config.utils")

return {
  {
    -- color scheme
    {
      "scottmckendry/cyberdream.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        vim.diagnostic.config({
          float = { border = "rounded" },
        })
        require("cyberdream").setup({
          transparent = true,
          italic_comments = true,
          hide_fillchars = true,
          terminal_colors = false,
          borderless_telescope = { border = false, style = "flat" },
          cache = true,
          theme = {
            variant = "auto",
            overrides = function(colours)
              return {
                TelescopePromptPrefix = { fg = colours.blue },
                TelescopeMatching = { fg = colours.cyan },
                TelescopeResultsTitle = { fg = colours.blue },
                TelescopePromptCounter = { fg = colours.cyan },
                TelescopePromptTitle = {
                  fg = colours.bg,
                  bg = colours.blue,
                  bold = true,
                },
              }
            end,
          },
        })

        vim.cmd("colorscheme cyberdream")
        -- vim.api.nvim_set_keymap(
        --   "n",
        --   "<leader>tt",
        --   ":CyberdreamToggleMode<CR>",
        --   { noremap = true, silent = true }
        -- )
        -- vim.api.nvim_create_autocmd("User", {
        --   pattern = "CyberdreamToggleMode",
        --   callback = function(ev)
        --     print("Switched to " .. ev.data .. " mode!")
        --   end,
        -- })
      end,
    },
  },
  -- transparent plugin
  {
    "xiyaowong/transparent.nvim",
    opts = {
      extra_groups = {
        "NormalFloat", -- plugins which have float panel such as Lazy, Mason, LspInfo
      },
    },
    -- plugin keymaps
    config = {
      k.set_keymap(
        "n",
        "<Leader>uo",
        "<cmd>TransparentToggle<cr>",
        { desc = "Toggle Transparent" }
      ),
    },
  },
  {
    -- winbar replacment
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
          local filename =
            vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[*]" .. filename
          end

          local icon, color =
            require("nvim-web-devicons").get_icon_color(filename)

          return {
            { icon, guifg = color },
            { " " },
            { filename },
          }
        end,
      })
    end,
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
        show_close_icon = false,
      },
    },
  },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local grappleline = require("grapple-line")
      local utils = require("config.utils")
      -- local copilot_colors = {
      --   [""] = utils.get_hlgroup("Comment"),
      --   ["Normal"] = utils.get_hlgroup("Comment"),
      --   ["Warning"] = utils.get_hlgroup("DiagnosticError"),
      --   ["InProgress"] = utils.get_hlgroup("DiagnosticWarn"),
      -- }

      return {
        options = {
          component_separators = { left = " ", right = " " },
          section_separators = { left = " ", right = " " },
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = { { "mode", icon = "" } },
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
            { "diff" },
            -- {
            --   "filetype",
            --   icon_only = true,
            --   separator = "",
            --   padding = { left = 1, right = 0 },
            -- },
            -- { "filename", padding = { left = 1, right = 0 } },
            {
              function()
                return require("nvim-navic").get_location()
              end,
              cond = function()
                return package.loaded["nvim-navic"]
                  and require("nvim-navic").is_available()
              end,
              color = utils.get_hlgroup("Comment", nil),
            },
          },
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
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
              "progress",
            },
            -- {
            --   "location",
            --   color = utils.get_hlgroup("Boolean"),
            -- },
          },
          lualine_z = {
            -- {
            --   "datetime",
            --   style = "  %X",
            -- },
            {
              function()
                local buffer_count = require("config.utils").get_buffer_count()

                return "+" .. buffer_count - 1 .. " "
              end,
              cond = function()
                return require("config.utils").get_buffer_count() > 1
              end,
              color = utils.get_hlgroup("Operator", nil),
              padding = { left = 1, right = 0 },
            },
            {
              grappleline.status,
              padding = { left = 0, right = 0 },
            },
          },
        },

        extensions = { "lazy", "toggleterm", "mason", "neo-tree", "trouble" },
      }
    end,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    opts = {
      input = {
        insert_only = false,
        start_in_insert = false,
        mappings = { i = { ["<C-c>"] = false } },
      },
    },
  },
}
