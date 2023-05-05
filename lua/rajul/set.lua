-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set Leader Key
vim.g.mapleader = " "

-- Tab Sizing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Disable line wrapping
vim.opt.wrap = false

-- Disable Search highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Colors
vim.opt.termguicolors = true

-- Scroll Offsets
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Update Time
vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Line Numbers
vim.cmd([[ set number ]])

-- Allow Pasting from macOS clipboard
vim.cmd([[set clipboard=unnamed]])
