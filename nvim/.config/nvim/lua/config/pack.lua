-- requires nvim 0.12
vim.cmd.packadd('nvim.difftool')
vim.cmd.packadd('nvim.undotree')

-- Open undotree on the left
vim.keymap.set('n',
    '<leader>u',
    function()
        require('undotree').open({ command = "aboveleft 30vnew" })
    end,
    { desc = 'Undo Tree' })
