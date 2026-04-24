-- Mappings {{{

vim.keymap.set('n', '<space>', '<nop>')
-- alternate insert escape
vim.keymap.set('i', 'jj', '<ESC>')

-- Centre half-page movements
vim.keymap.set('n', '<C-U>', '<C-U>zz')
vim.keymap.set('n', '<C-D>', '<C-D>zz')

-- stay in visual mode when indenting
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- terminal mappings
vim.keymap.set('t', '<ESC>', "<C-\\><C-n>")

-- pane navigation
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')

-- panel navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- tab navigation
vim.keymap.set('n', '[t', ':tabprevious<CR>')
vim.keymap.set('n', ']t', ':tabnext<CR>')
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>')
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>')

-- Keep search pattern at the center of the screen
vim.keymap.set('n', 'n', 'nzz', { silent = true })
vim.keymap.set('n', 'N', 'Nzz', { silent = true })
vim.keymap.set('n', '*', '*zz', { silent = true })
vim.keymap.set('n', '#', '#zz', { silent = true })
vim.keymap.set('n', 'g*', 'g*zz', { silent = true })
vim.keymap.set('n', 'g#', 'g#zz', { silent = true })

-- nvim 0.11+ diagnostics
vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

-- clear hlsearch
vim.keymap.set('n', '<leader>/', ':let @/=""<CR>')

-- lazy write
vim.keymap.set('n', '<leader>x', ':x<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>W', ':wall ++p<CR>')

-- yank to end of line
vim.keymap.set('n', 'Y', 'y$')

-- Attempt to prevent netrw bugs
vim.g.netrw_fastbrowse = 0

local filetype_quit = {
    ['qf'] = true,
    ['ql'] = true,
    ['netrw'] = true,
    ['nvim-undotree'] = true,
}

vim.keymap.set('n', 'q', function()
    local buf = vim.api.nvim_win_get_buf(0)
    if vim.bo[buf].readonly or filetype_quit[vim.bo[buf].filetype] then
        return ':close<CR>'
    else
        return 'q'
    end
end, { expr = true })
-- }}}
