
local configs = require("nvim-treesitter.configs")
configs.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    disable = { "elixir" },
  }
}
vim.cmd[[set fillchars+=vert:\ ]]
vim.cmd[[colorscheme dracula]]
vim.g.dracula_show_end_of_buffer = false
