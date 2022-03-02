local lsp_installer = require("nvim-lsp-installer")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local servers = {"elixirls", "rust_analyzer", "solargraph", "sumneko_lua", "html", "tailwindcss"}

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

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

  require("lsp-format").on_attach(client)
end

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    server:install()
  end
end

lsp_installer.on_server_ready(function(server)
  local opts = {
    capabilities = capabilities,
    on_attach = on_attach
  }

  if server.name == "sumneko_lua" then
    local lua_opts = {
      plugins = true,
      lspconfig = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "use" }
            }
          }
        }
      }
    }

    local options = vim.tbl_deep_extend("force", require("lua-dev").setup(lua_opts), opts)
    server:setup(options)
    return
  end
  if server.name == "rust_analyzer" then
    local options = { settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } } }
    options = vim.tbl_deep_extend("force", options, opts)

      require("rust-tools").setup {
        debuggables = { use_telescope = true },
        runnables = { use_telescope = true },
        inlay_hints = { show_variable_name = true, },
        server = vim.tbl_deep_extend("force", server:get_default_options(), options),
      }
      server:attach_buffers()
      require("rust-tools").start_standalone_if_required()
      return
  end
  server:setup(opts)
end)

