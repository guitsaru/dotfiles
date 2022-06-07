require("nvim-lsp-installer").setup({})
require("rust-tools").setup({})
require("elixir").setup({})

local lspconfig = require("lspconfig")
local luadev = require("lua-dev").setup({
    lspconfig = {
      settings = {
        Lua = {
          diagnostics = {
            globals = {"use"}
          }
        }
      }
    }
})

lspconfig.sumneko_lua.setup(luadev)
lspconfig.solargraph.setup({})
lspconfig.tailwindcss.setup({ userLanguages = { eelixir = "html-eex" } })
