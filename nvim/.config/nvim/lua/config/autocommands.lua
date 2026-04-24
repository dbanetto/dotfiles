-- autocmd {{{

vim.api.nvim_create_autocmd("FocusLost", {
    pattern = "*",
    callback = function(_)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<ESC>', true, false, true), 'n', false)
    end
})

vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function(_)
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "auto"
        vim.opt_local.foldcolumn = "auto"
    end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = "term://*",
    callback = function(_)
        vim.cmd('startinsert')
    end
})

vim.api.nvim_create_autocmd("WinEnter", {
    pattern = "term://*",
    callback = function(_)
        vim.cmd('startinsert')
    end
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
    end,
})

-- Annotates each terminal command
-- Requires semantic escape sequences (OSC 133) to mark where each prompt starts and ends.
local ns = vim.api.nvim_create_namespace('my.terminal.prompt')
vim.api.nvim_create_autocmd('TermRequest', {
    callback = function(args)
        if string.match(args.data.sequence, '^\027]133;A') then
            local lnum = args.data.cursor[1]
            vim.api.nvim_buf_set_extmark(args.buf, ns, lnum - 1, 0, {
                sign_text = '▶',
                sign_hl_group = 'SpecialChar',
            })
        end
    end,
})

-- }}}
