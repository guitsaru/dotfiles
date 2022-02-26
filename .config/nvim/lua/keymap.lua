local wk = require("which-key")

wk.register({
    ["<SPACE>"] = { ":e#<CR>", "Previous Buffer" },
    b = { "<cmd>NvimTreeToggle<CR>", "Toggle File Explorer" },
    f = {
      name = "Find",
      a = { "<cmd>Telescope live_grep theme=ivy<CR>", "Find in Project" },
      f = { "<cmd>Telescope find_files theme=ivy<CR>", "Find File" },
      b = { "<cmd>Telescope buffers theme=ivy<CR>", "Find Buffer" },
      h = { "<cmd>Telescope help_tags theme=ivy<CR>", "Find Tag" },
      p = { "<cmd>Telescope projects theme=ivy<CR>", "Find Project" },
    },
    l = {
      name = "LSP",
      r = { "<cmd>Telescope lsp_references theme=ivy<CR>", "References" },
      s = { "<cmd>Telescope lsp_references theme=ivy<CR>", "Symbols" },
      o = { "<cmd>SymbolsOutline<CR>", "Outline" },
    },
    t = {
      name = "Test",
      t = { "<cmd>TestNearest<CR>", "Nearest" },
      T = { "<cmd>TestFile<CR>", "File" },
      a = { "<cmd>TestSuite<CR>", "Project" },
      l = { "<cmd>TestLast<CR>", "Last" },
      g = { "<cmd>TestVisit<CR>", "Visit" },
    },
    c = {
      name = "Config",
      f = { "<cmd>lua require('config').find_config_files()<CR>", "Find" },
      s = { "<cmd>source $MYVIMRC<CR>", "Source" },
      ["/"] = { "<cmd>lua require('config').live_grep_config_files()<CR>", "Search" },
    },
    p = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },
    d = {
      name = "Diagnostics",
      d = { "<cmd>Trouble<CR>", "Show Diagnostics" },
      w = { "<cmd>Trouble workspace_diagnostics<CR>", "Show Workspace Diagnostics" },
      l = { "<cmd>Trouble loclist<CR>", "Show Location List Diagnostics" },
      q = { "<cmd>Trouble quickfix<CR>", "Show Quickfixes" },
    },
    g = {
      name = "Git",
      g = { "<cmd>Git<Cr>", "Summary" },
      b = { "<cmd>Git blame<Cr>", "Blame" },
      c = { "<cmd>Git commit<Cr>", "Commit" },
      p = { "<cmd>Git push<Cr>", "Push" },
      u = { "<cmd>Git pull<Cr>", "Pull" },
      d = { "<cmd>Git diff<Cr>", "Diff" },
    },
}, { prefix = "<leader>" })

vim.cmd("autocmd FileType * lua WhichKeyLang()")
function WhichKeyLang()
  local file_type = vim.api.nvim_buf_get_option(0, "filetype")
  if file_type == "rust" then
    wk.register({
      r = {
        name = "Rust",
        r = { "<cmd>RustRunnables<CR>", "Runnables" },
        c = { "<cmd>RustOpenCargo<CR>", "Edit Cargo.toml" },
        p = { "<cmd>RustParentModule<CR>", "Go to Parent Module" },
        f = { "<cmd>RustFmt<CR>", "Format" },
      }
    }, { prefix = "<leader>" })
  end
end
