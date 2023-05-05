local nvimTree = require('nvim-tree')

nvimTree.setup({
    filters = {
        dotfiles = true,
    },
})


vim.keymap.set('n', '<Leader>t', ':NvimTreeToggle<CR>')
