require("nvim-lsp-installer").setup({})

local on_attach = function(client, bufnr)
   require("which-key").register({
      l = {
        name = "LSP",
        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to Declaration" },
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to Implementation" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Go to Type Definition" },
        R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
        f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
      }
  }, { prefix = "<leader>" })

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  require("lsp-format").on_attach(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("rust-tools").setup({ server = { capabilities = capabilities, on_attach = on_attach }})
require("elixir").setup({ server = { capabilities = capabilities, on_attach = on_attach }})

local lspconfig = require("lspconfig")
local luadev = require("lua-dev").setup({
    on_attach = on_attach,
    capabilities = capabilities,

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
lspconfig.solargraph.setup({ on_attach = on_attach, capabilities = capabilities })
lspconfig.tailwindcss.setup({ on_attach = on_attach, capabilities = capabilities, userLanguages = { eelixir = "html-eex" } })

