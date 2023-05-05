local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'lua_ls',
	'rust_analyzer',
    'gopls',
    'cmake',
    'clangd'
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.set_preferences({
	sign_icons = { }
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    -- vim.keymap.set("n", "gv", ':vsp<cr> <cmd> lua vim.lsp.buf.definition()<cr>' , opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)


    -- Define key mappings for going to definition in a vertical and horizontal split
    vim.api.nvim_set_keymap('n', 'gv', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'gh', '<cmd>split | lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
end)

lsp.setup()
