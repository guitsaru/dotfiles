return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Snacks.nvim is already included in LazyVim, just ensure input is enabled
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    ---@type opencode.Opts
    opts = {
      -- Your configuration, if any — see lua/opencode/config.lua
    },
    keys = {
      -- Main keymaps
      { "<leader>oA", function() require("opencode").ask() end, desc = "Ask opencode" },
      { "<leader>oa", function() require("opencode").ask("@cursor: ") end, desc = "Ask opencode about this", mode = "n" },
      { "<leader>oa", function() require("opencode").ask("@selection: ") end, desc = "Ask opencode about selection", mode = "v" },
      { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle embedded opencode" },
      
      -- Session management
      { "<leader>on", function() require("opencode").command("session_new") end, desc = "New opencode session" },
      { "<leader>oy", function() require("opencode").command("messages_copy") end, desc = "Copy last message" },
      
      -- Navigation
      { "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, desc = "Scroll messages up" },
      { "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, desc = "Scroll messages down" },
      
      -- Prompt selection
      { "<leader>op", function() require("opencode").select_prompt() end, desc = "Select prompt", mode = { "n", "v" } },
      
      -- Custom prompts
      { "<leader>oe", function() require("opencode").prompt("Explain @cursor and its context") end, desc = "Explain code near cursor" },
      { "<leader>or", function() require("opencode").prompt("Review @selection for bugs and improvements") end, desc = "Review selection", mode = "v" },
      { "<leader>of", function() require("opencode").prompt("Fix the @diagnostics in this file") end, desc = "Fix diagnostics" },
      { "<leader>od", function() require("opencode").prompt("Generate documentation for @selection") end, desc = "Document selection", mode = "v" },
    },
  },
}