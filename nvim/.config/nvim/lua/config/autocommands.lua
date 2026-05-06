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

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "*" },
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if lang == nil then
            return
        end

        if not vim.treesitter.language.add(lang) then
            -- this stupid tracking is here only because
            -- they have added warnings on absent parsers
            local available = vim.g.ts_available
                or require("nvim-treesitter").get_available()
            if not vim.g.ts_available then
                vim.g.ts_available = available
            end
            if vim.tbl_contains(available, lang) then
                require("nvim-treesitter").install(lang)
            end
        end

        if vim.treesitter.language.add(lang) then
            vim.treesitter.start(args.buf, lang)
            vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            vim.wo[0][0].foldmethod = "expr"
        end
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
