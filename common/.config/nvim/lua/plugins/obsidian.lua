local utils = require("config.utils")
local keymap = utils.keymap

return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "marvan",
        path = "~/Documents/Notes/",
      },
    },
    notes_subdir = "inbox",
    new_notes_location = "notes_subdir",
    disable_frontmatter = true,
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M:%S",
      substitutions = {
        week = function()
          return os.date("%Y-%U")
        end,
      },
    },
    mappings = {
      -- register which-key mapping
      keymap("n", "<leader>o", "", { desc = "obsidian" }),
      -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
      keymap(
        "n",
        "gf",
        "<cmd>lua require('obsidian').util.gf_passthrough()<cr>",
        { desc = "Obsidian Go to File" }
      ),
      keymap(
        "n",
        "<Leader>oc",
        "<cmd>lua require('obsidian').util.toggle_checkbox()<cr>",
        { desc = "Toggle Checkbox" }
      ),
      -- change to notes directory
      keymap(
        "n",
        "<leader>oo",
        "<cmd>cd $HOME/Documents/Notes/<cr>",
        { desc = "Change to Notes Directory" }
      ),
      -- convert note to template
      keymap(
        "n",
        "<leader>on",
        "<cmd>ObsidianTemplate note<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
        { desc = "Convert to Template" }
      ),
      keymap(
        "n",
        "<leader>ox",
        "<cmd>ObsidianTemplate daily<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
        { desc = "Convert to Template" }
      ),
      keymap(
        "n",
        "<leader>ow",
        "<cmd>ObsidianTemplate weekly<cr> :lua vim.cmd([[1,/^\\S/s/^\\n\\{1,}//]])<cr>",
        { desc = "Convert to Template" }
      ),
      -- strip date from note title and replace dashes with spaces
      -- must have cursor on title
      keymap(
        "n",
        "<leader>of",
        ":s/\\(# \\)[^_]*_/\\1/ | s/-/ /g<cr>",
        { desc = "Format Note Title" }
      ),
      -- grep search for files in full vault
      keymap(
        "n",
        "<leader>oz",
        ":ObsidianSearch<cr>",
        { desc = "Grep Search Notes" }
      ),
      -- search for files in full vault
      keymap(
        "n",
        "<leader>os",
        ":Telescope find_files search_dirs={'$HOME/Documents/Notes'}<cr>",
        { desc = "Search Notes" }
      ),
      -- move file in current buffer to zettelkasten folder
      keymap(
        "n",
        "<leader>ok",
        ":!mv '%:p' $HOME/Documents/Notes/zettelkasten/<cr>:bd<cr>",
        { desc = "Move to Zettelkasten" }
      ),
      -- delete file in current buffer
      keymap(
        "n",
        "<leader>odd",
        ":!rm '%:p'<cr>:bd<cr>",
        { desc = "Delete Note" }
      ),
    },
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
  },
}
