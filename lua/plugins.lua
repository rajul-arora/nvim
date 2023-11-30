return require('packer').startup(function(use) 
    -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- Telescope 
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.3',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Themes
  use "EdenEast/nightfox.nvim" 

  -- LSP Configuration
  use "neovim/nvim-lspconfig"

  -- Autocompletion engine
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',      -- buffer completions
      'hrsh7th/cmp-path',        -- path completions
      'hrsh7th/cmp-cmdline',     -- cmdline completions
      'hrsh7th/cmp-nvim-lsp',    -- LSP completions
      'hrsh7th/cmp-nvim-lua',    -- Neovim Lua API completions
      -- Add other sources as needed
    }
  }

  use'hrsh7th/vim-vsnip'

end)
