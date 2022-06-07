require("nvim-lsp-installer").setup { automatic_installation = true }
require("rust-tools").setup({})
require("elixir").setup({})

local lspconfig = require("lspconfig")
local luadev = require("lua-dev").setup({})

lspconfig.sumneko_lua.setup(luadev)
lspconfig.solargraph.setup({})
lspconfig.tailwindcss.setup({ userLanguages = { eelixir = "html-eex" } })
