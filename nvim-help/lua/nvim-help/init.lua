local M = {}

local help_buf = nil
local help_win = nil

local function get_default_keybindings()
    return {
        { mode = "n", key = "<leader>h", desc = "Show help overlay" },
        { mode = "i", key = "jk", desc = "Exit insert mode" },
        -- Add more default keybindings here
    }
end

local function get_keybindings()
    return user_keybindings or get_default_keybindings()
end

local function center_text(line, width)
    local padding = math.floor((width - #line) / 2)
    return string.rep(" ", padding) .. line
end

local function create_floating_window() 
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  help_buf = vim.api.nvim_create_buf(false, true)
    help_win = vim.api.nvim_open_win(help_buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'single',
    })

    local keybindings = get_keybindings()    
    local lines = { center_text("Neovim Keymap Help", width) } -- Add title line
    table.insert(lines, "") -- Add an empty line after the title for spacing
  
    for _, binding in ipairs(keybindings) do
         table.insert(lines, string.format("%s: %s -> %s", binding.mode, binding.key, binding.desc))
    end
      
    vim.api.nvim_buf_set_lines(help_buf, 0, -1, false, lines) 

    -- Set up key mapping to close the window on Escape
    vim.api.nvim_buf_set_keymap(help_buf, 'n', '<Esc>', ':lua require("nvim-help").close_help()<CR>', { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(help_buf, 'i', '<Esc>', '<C-\\><C-n>:lua require("nvim-help").close_help()<CR>', { noremap = true, silent = true })

end

function M.toggle_help()
    if help_win and vim.api.nvim_win_is_valid(help_win) then
        vim.api.nvim_win_close(help_win, true)
        help_win = nil
        help_buf = nil
    else
        create_floating_window()
    end
end

function M.close_help()
    if help_win and vim.api.nvim_win_is_valid(help_win) then
        vim.api.nvim_win_close(help_win, true)
        help_win = nil
        help_buf = nil
    end
end

function M.setup(config)
    user_keybindings = config.keybindings or get_default_keybindings()
    vim.api.nvim_set_keymap('n', '<leader>h', ':lua require("nvim-keybindings-help").toggle_help()<CR>', { noremap = true, silent = true })
end

return M
