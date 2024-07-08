---------------------
-- Lazy.Nvim Setup --
---------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Example using a list of specs with the default options
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct


local keybindings = {
  { mode = "n", key = "<leader>h", desc = "Toggle help overlay" },
  { mode = "n", key = "<leader>ff", desc = "Toggle Find Files"},
  { mode = "n", key = "<leader>fg", desc = "Toggle Live Grep"},
  { mode = "n", key = "Ctrl + w + Arrow Key", desc = "Switch between splits"}
}

require("lazy").setup({
  "folke/which-key.nvim",
  "Shatur/neovim-ayu",
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'nvim-help',
    dir = '~/.config/nvim/nvim-help',
    config = function()
      require('nvim-help').setup({
        keybindings = keybindings
      })
      vim.api.nvim_set_keymap('n', '<leader>h', ':lua require("nvim-help").toggle_help()<CR>', { noremap = true, silent = true })
    end, 
  },
  { 
    'nvim-telescope/telescope.nvim', 
    tag = '0.1.6', 
    dependencies = { 'nvim-lua/plenary.nvim' }
  }
})

-------------------------
-- Basic Configuration --
-------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

-- buffer-scoped
vim.opt.autoindent = true

-- global scope
vim.opt.autowrite = true

-- set tab behavior
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- enable line numbering
vim.opt.number = true

vim.opt.mouse = 'a'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = true

-- Connect to macOS Keyboard
vim.cmd [[ set clipboard+=unnamedplus ]]

-- Color Theme
vim.cmd('colorscheme ayu')

----------------------------------
-- Telescope.nvim Configuration --
----------------------------------

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

---------------------------
-- Lualine Configuration --
---------------------------

local lualine = require('lualine')
lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'ayu_dark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


