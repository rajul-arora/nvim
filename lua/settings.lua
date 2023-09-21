-- use space as a the leader key
vim.g.mapleader = ' '

-- buffer-scoped
vim.opt.autoindent = true
-- window-scoped
vim.opt.cursorline = true
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

vim.cmd [[
  set clipboard+=unnamedplus
]]

vim.wo.colorcolumn = '100'
