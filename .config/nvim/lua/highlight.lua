local configs = require("nvim-treesitter.configs")

configs.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = {},
  }
}

vim.cmd[[set fillchars+=vert:\ ]]
