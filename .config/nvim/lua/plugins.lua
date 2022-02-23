vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local fn = vim.fn
local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

vim.cmd [[packadd packer.nvim]]
return require("packer").startup(function()
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use "tpope/vim-fugitive"
  use "tpope/vim-sleuth"
  use "tpope/vim-commentary"
  use "tpope/vim-eunuch"
  use "sbdchd/neoformat"
  use 'voldikss/vim-floaterm'
  use "jssee/vim-delight"

  use "nvim-treesitter/nvim-treesitter"
  use 'Mofiqul/dracula.nvim'
  use "sheerun/vim-polyglot"
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
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

  use { "nvim-telescope/telescope.nvim", requires = { {"nvim-lua/plenary.nvim"} }}

  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"

  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"

  use "vim-test/vim-test"

  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  }

  use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } }
  use "arkav/lualine-lsp-progress"

  if packer_bootstrap then
    require("packer").sync()
  end
end)
