return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      -- Define the group name
      { "<leader>i", group = "claude code" },
      
      -- Main keymaps
      { "<leader>ic", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>if", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ir", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>iC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      
      -- Model and buffer management
      { "<leader>im", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ib", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      
      -- Visual mode selection
      { "<leader>is", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      
      -- Diff management
      { "<leader>ia", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>id", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}