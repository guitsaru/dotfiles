return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        acp = {
          claude_code = function()
            return require("codecompanion.adapters").extend("claude_code", {
              env = {
                CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "claude_code",
        },
        inline = {
          adapter = "claude_code",
        },
        cmd = {
          adapter = "claude_code",
        },
      },
      display = {
        action_palette = {
          provider = "telescope",
        },
      },
    })
  end,
  keys = {
    { "<leader>i", group = "AI" },
    { "<leader>ia", "<cmd>CodeCompanionActions<cr>", desc = "Actions" },
    { "<leader>ic", "<cmd>CodeCompanionChat<cr>", desc = "Chat" },
    { "<leader>it", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
    { "<leader>ii", "<cmd>CodeCompanion<cr>", desc = "Inline Assistant", mode = { "n", "v" } },
    { "<leader>ie", "<cmd>CodeCompanion /explain<cr>", desc = "Explain Code", mode = "v" },
    { "<leader>if", "<cmd>CodeCompanion /fix<cr>", desc = "Fix Code", mode = "v" },
    { "<leader>io", "<cmd>CodeCompanion /optimize<cr>", desc = "Optimize Code", mode = "v" },
    { "<leader>id", "<cmd>CodeCompanion /lsp<cr>", desc = "LSP Diagnostics", mode = "v" },
    { "<leader>iu", "<cmd>CodeCompanion /tests<cr>", desc = "Unit Tests", mode = "v" },
    { "<leader>im", "<cmd>CodeCompanion /commit<cr>", desc = "Commit Message" },
  },
  cmd = {
    "CodeCompanion",
    "CodeCompanionChat",
    "CodeCompanionCmd", 
    "CodeCompanionActions",
  },
  init = function()
    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}