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

require("lazy").setup({
  -- Themes
  "Shatur/neovim-ayu",
  "sho-87/kanagawa-paper.nvim",
  -- Lualine
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'xiyaowong/transparent.nvim',
  "neovim/nvim-lspconfig",
  {
    "dundalek/lazy-lsp.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      {"VonHeikemen/lsp-zero.nvim", branch = "v3.x"},
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local lsp_zero = require("lsp-zero")

      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings to learn the available actions
        lsp_zero.default_keymaps({
          buffer = bufnr,
          preserve_mappings = false
        })
      end)

      require("lazy-lsp").setup {
        excluded_servers = {
          "biome", "quick_lint_js", "tailwindcss", "denols"
        },
        prefer_local = true,
        -- Override config for specific servers 

        conifgs = {
          lua_ls = {
            settings = {
              Lua = {
               diagnostics = {
                  globals = { "vim" },
                }
              }
            }
          },
          ts_ls = {
            settings = {
              typescript = {
                tsserver = {
                  experimental = {
                    types = { "Deno" } -- Ensure Deno is defined
                  }
                }
              },
              javascript = {
                tsserver = {
                  experimental = {
                    types = { "Deno" } -- For JavaScript files too
                  }
                }
              }
            }
          },
        },
      }
    end,
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

-- Center the search results when cycling with 'n' or 'N'
vim.cmd([[
  augroup CenterSearch
    autocmd!
    autocmd CursorMoved * if mode() == 'n' && (v:hlsearch == 1) | normal! zz | endif
  augroup END
]])

-- Connect to macOS Keyboard
vim.cmd [[ set clipboard+=unnamedplus ]]

-- Color Theme
vim.cmd('colorscheme kanagawa-paper')

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
    theme = 'kanagawa-paper',
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

----------------------------
-- Transparent.nvim Setup --
----------------------------
vim.g.transparent_enabled = true

-----------------------
-- LSP Configuration --
-----------------------

local lspConfig = require("lspconfig")

