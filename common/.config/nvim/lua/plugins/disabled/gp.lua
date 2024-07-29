local default_chat_system_prompt = "You are a general AI assistant.\n\n"
  .. "The user provided the additional info about how they would like you to respond:\n\n"
  .. "- If you're unsure don't guess and say you don't know instead.\n"
  .. "- Ask question if you need clarification to provide better answer.\n"
  .. "- Think deeply and carefully from first principles step by step.\n"
  .. "- Zoom out first to see the big picture and then zoom in to details.\n"
  .. "- Use Socratic method to improve your thinking and coding skills.\n"
  .. "- Don't elide any code from your output if the answer requires coding.\n"
  .. "- Take a deep breath; You've got this!\n"

local default_code_system_prompt = "You are an AI working as a code editor.\n\n"
  .. "Use 2 SPACES FOR INDENTATION.\n"
  .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
  .. "START AND END YOUR ANSWER WITH:\n\n```"

local config = {
  openai_api_key = "nil",
  providers = {
    ollama = {
      disable = false,
      endpoint = "http://ollama.lan/v1/chat/completions",
    },
    openai = {
      disable = true,
    },
  },

  -- prefix for all commands
  cmd_prefix = "Gp",
  -- optional curl parameters (for proxy, etc.)
  -- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
  curl_params = {},

  -- directory for persisting state dynamically changed by user (like model or persona)
  state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/persisted",
  -- directory for storing chat files
  chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/chats",

  agents = {
    {
      provider = "ollama",
      disable = true,
      name = "ChatOllamaLlama3",
    },
    {
      provider = "ollama",
      disable = true,
      name = "CodeOllamaLlama3",
    },
    {
      provider = "ollama",
      name = "ChatAstral",
      chat = true,
      command = false,
      -- string with model name or table with model name and parameters
      model = {
        model = "codestral:latest",
        -- num_ctx = 8192,
      },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = default_chat_system_prompt,
    },
    {
      provider = "ollama",
      name = "CodeAstral",
      chat = true,
      command = false,
      -- string with the Copilot engine name or table with engine name and parameters if applicable
      model = {
        model = "codestral:latest",
        temperature = 1.9,
        top_p = 1,
        -- num_ctx = 8192,
      },
      -- system prompt (use this to specify the persona/role of the AI)
      system_prompt = default_code_system_prompt,
    },
  },

  -- chat user prompt prefix
  chat_user_prefix = "💬:",
  -- chat assistant prompt prefix (static string or a table {static, template})
  chat_assistant_prefix = { "🤖:", "[{{agent}}]" },
  -- chat topic generation prompt
  chat_topic_gen_prompt = "Summarize the topic of our conversation above"
    .. " in two or three words. Respond only with those words.",
  -- explicitly confirm deletion of a chat file
  chat_confirm_delete = true,
  -- conceal model parameters in chat
  chat_conceal_model_params = false,

  -- local shortcuts bound to the chat buffer
  -- (be careful to choose something which will work across specified modes)
  chat_shortcut_respond = {
    modes = { "n", "i", "v", "x" },
    shortcut = "<C-g><C-g>",
  },
  chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
  chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
  chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },

  -- default search term when using :GpChatFinder
  chat_finder_pattern = "topic ",
  -- if true, finished ChatResponder won't move the cursor to the end of the buffer
  chat_free_cursor = false,
  -- use prompt buftype for chats (:h prompt-buffer)
  chat_prompt_buf_type = false,

  -- how to display GpChatToggle or GpContext: popup / split / vsplit / tabnew
  toggle_target = "vsplit",

  -- styling for chatfinder
  -- border can be "single", "double", "rounded", "solid", "shadow", "none"
  style_chat_finder_border = "single",
  -- margins are number of characters or lines
  style_chat_finder_margin_bottom = 8,
  style_chat_finder_margin_left = 1,
  style_chat_finder_margin_right = 2,
  style_chat_finder_margin_top = 2,
  -- how wide should the preview be, number between 0.0 and 1.0
  style_chat_finder_preview_ratio = 0.5,

  -- styling for popup
  -- border can be "single", "double", "rounded", "solid", "shadow", "none"
  style_popup_border = "single",
  -- margins are number of characters or lines
  style_popup_margin_bottom = 8,
  style_popup_margin_left = 1,
  style_popup_margin_right = 2,
  style_popup_margin_top = 2,
  style_popup_max_width = 160,
  -- command config and templates below are used by commands like GpRewrite, GpEnew, etc.
  -- command prompt prefix for asking user for input (supports {{agent}} template variable)
  command_prompt_prefix_template = "🤖 {{agent}} ~ ",
  -- auto select command response (easier chaining of commands)
  -- if false it also frees up the buffer cursor for further editing elsewhere
  command_auto_select_response = true,

  -- templates
  template_selection = "I have the following from {{filename}}:"
    .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
  template_rewrite = "I have the following from {{filename}}:"
    .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
    .. "\n\nRespond exclusively with the snippet that should replace the selection above.",
  template_append = "I have the following from {{filename}}:"
    .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
    .. "\n\nRespond exclusively with the snippet that should be appended after the selection above.",
  template_prepend = "I have the following from {{filename}}:"
    .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
    .. "\n\nRespond exclusively with the snippet that should be prepended before the selection above.",
  template_command = "{{command}}",
  hooks = {
    InspectPlugin = function(plugin, params)
      local bufnr = vim.api.nvim_create_buf(false, true)
      local copy = vim.deepcopy(plugin)
      local key = copy.config.openai_api_key or ""
      copy.config.openai_api_key = key:sub(1, 3)
        .. string.rep("*", #key - 6)
        .. key:sub(-3)
      for provider, _ in pairs(copy.providers) do
        local s = copy.providers[provider].secret
        if s and type(s) == "string" then
          copy.providers[provider].secret = s:sub(1, 3)
            .. string.rep("*", #s - 6)
            .. s:sub(-3)
        end
      end
      local plugin_info =
        string.format("Plugin structure:\n%s", vim.inspect(copy))
      local params_info =
        string.format("Command params:\n%s", vim.inspect(params))
      local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
      vim.api.nvim_win_set_buf(0, bufnr)
    end,
    -- GpImplement rewrites the provided selection/range based on comments in it
    Implement = function(gp, params)
      local template = "Having following from {{filename}}:\n\n"
        .. "```{{filetype}}\n{{selection}}\n```\n\n"
        .. "Please rewrite this according to the contained instructions."
        .. "\n\nRespond exclusively with the snippet that should replace the selection above."

      local agent = gp.get_command_agent()
      gp.info("Implementing selection with agent: " .. agent.name)
      gp.Prompt(params, gp.Target.rewrite, agent.model, template)
    end,
  },
}
return {
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup(config)
    end,
  },
}
