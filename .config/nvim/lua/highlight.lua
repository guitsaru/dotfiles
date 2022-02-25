local configs = require("nvim-treesitter.configs")

configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "elixir" },
  }
}

vim.g.tokyonight_style = "night"
vim.cmd[[set fillchars+=vert:\ ]]
vim.cmd[[colorscheme tokyonight]]
