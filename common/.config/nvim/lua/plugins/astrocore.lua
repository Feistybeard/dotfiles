---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    options = {
      opt = { -- vim.opt.<key>
        scrolloff = 10,
        sidescrolloff = 8,
        termguicolors = true,
        ignorecase = true,
        smartcase = true,
        conceallevel = 2,
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,
      },
      g = { -- vim.g.<key>
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    mappings = {
      -- first key is the mode
      n = {
        -- center screen after half page up/down and search
        ["<C-u>"] = { "<C-u>zz" },
        ["<C-d>"] = { "<C-d>zz" },
        ["n"] = { "nzzzv" },
        ["N"] = { "Nzzzv" },

        ["<Leader>oc"] = {
          function() require("obsidian").util.toggle_checkbox() end,
          desc = "Toggle checkbox",
        },
        ["<Leader>oo"] = { ":cd $HOME/Documents/Notes<CR>", desc = "Change to notes directory" },
        -- convert note to template and remove leading white space
        ["<Leader>on"] = {
          ":ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
          desc = "Convert to template",
        },
        -- strip date from note title and replace dashes with spaces
        -- must have cursor on title
        ["<Leader>of"] = { ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>", desc = "Format note title" },
        -- search for files in full vault
        ["<Leader>os"] = {
          ':Telescope find_files search_dirs={"$HOME/Documents/Notes"}<cr>',
          desc = "Search notes",
        },
        ["<Leader>oz"] = {
          ':Telescope live_grep search_dirs={"$HOME/Documents/Notes"}<cr>',
          desc = "Search notes content",
        },
        -- move file in current buffer to zettelkasten folder
        ["<Leader>ok"] = {
          ":!mv '%:p' $HOME/Documents/Notes/zettelkasten/<cr>:bd<cr>",
          desc = "Move to Zettelkasten",
        },
        -- delete file in current buffer
        ["<Leader>odd"] = {
          ":!rm '%:p'<cr>:bd<cr>",
          desc = "Delete note",
        },
        ["<Leader>op"] = {
          ":MarkdownPreviewToggle<cr>",
          desc = "Markdown preview toggle(in browser)",
        },

        -- which key mappings
        ["<Leader>a"] = { desc = "Ai" },
        ["<Leader>o"] = { desc = "Obsidian" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
