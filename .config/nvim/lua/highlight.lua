local configs = require("nvim-treesitter.configs")

configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "elixir" },
  }
}

vim.g.onedark_config = { style = "darker" }
vim.cmd[[set fillchars+=vert:\ ]]
vim.cmd[[colorscheme onedark]]
