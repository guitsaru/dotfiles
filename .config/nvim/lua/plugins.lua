vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

vim.cmd [[packadd packer.nvim]]
return require("packer").startup(function()
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use "tpope/vim-sleuth"
  use "tpope/vim-eunuch"
  use "jssee/vim-delight"
  use "simrat39/symbols-outline.nvim"
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("neogit").setup({})
    end
  }

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  use {
    "doums/floaterm.nvim",
    config = function()
      require("floaterm").setup({
          layout = "bottom",
          width = 1,
          height = 1,
          keymaps = { exit = "<C-t>", normal = "<esc>" }
      })
    end
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("highlight")
    end
  }

  use "sheerun/vim-polyglot"

  use({
      "themercorp/themer.lua",
      config = function()
        require("themer").setup({
          colorscheme = "dracula",
        })
      end
  })

  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
      require('telescope').load_extension('projects')
    end
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require("nvim-tree").setup({ respect_buf_cwd = true })
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim"},
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_ivy({})
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }

  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "lukas-reineke/lsp-format.nvim"
  use {
    "L3MON4D3/LuaSnip",
    requires = {"hrsh7th/nvim-cmp", "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp"},
    config = function()
      require("completion")
      require("snippets")
    end
  }

  use {
    "neovim/nvim-lspconfig",
    requires = {
      "nvim-lua/plenary.nvim",
      "folke/lua-dev.nvim",
      "williamboman/nvim-lsp-installer",
      "simrat39/rust-tools.nvim",
      "mhanberg/elixir.nvim"
    },
    config = function()
      require("lsp")
    end
  }

  use {
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup({
            null_ls = {
              enabled = true,
              name = "crates.nvim",
            },
        })
    end,
}

  use "vim-test/vim-test"

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        ignore_missing = true,
      }
      require("keymap")
    end
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup {
        sources = {
          require("null-ls").builtins.diagnostics.credo,
          require("null-ls").builtins.formatting.rustywind,
          -- require("null-ls").builtins.formatting.mix,
          require("null-ls").builtins.formatting.rustfmt,
        }
      }
    end
  }

  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("status")
    end
  }

  use "arkav/lualine-lsp-progress"

  use "stevearc/dressing.nvim"
  use({
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker")
    end,
  })

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
