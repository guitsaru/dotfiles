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

  use "tpope/vim-fugitive"
  use "tpope/vim-sleuth"
  use "tpope/vim-commentary"
  use "tpope/vim-eunuch"
  -- use 'voldikss/vim-floaterm'
  use "doums/floaterm.nvim"
  use "jssee/vim-delight"
  use "simrat39/symbols-outline.nvim"

  use "nvim-treesitter/nvim-treesitter"
  use 'Mofiqul/dracula.nvim'
  use "folke/tokyonight.nvim"
  use "navarasu/onedark.nvim"
  use "sheerun/vim-polyglot"

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
      vim.g.nvim_tree_respect_buf_cwd = 1
      require("nvim-tree").setup({
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true
        },
      })
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

  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
  use "lukas-reineke/lsp-format.nvim"

  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "folke/lua-dev.nvim"
  use {
    "simrat39/rust-tools.nvim",
    requires = { "nvim-lua/plenary.nvim" }
  }

  use {
    'saecki/crates.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup()
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
    end
  }

  use {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require("null-ls").setup {
        sources = {
          require("null-ls").builtins.diagnostics.credo,
          require("null-ls").builtins.formatting.rustywind,
          require("null-ls").builtins.formatting.mix,
          require("null-ls").builtins.formatting.rustfmt,
        }
      }
    end
  }

  use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }
  use "arkav/lualine-lsp-progress"

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
