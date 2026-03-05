return {
    {
        -- gitsigns {{{
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]h", function()
                    if vim.wo.diff then return "]c" end
                    vim.schedule(function() gs.next_hunk() end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[h", function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() gs.prev_hunk() end)
                    return "<Ignore>"
                end, { expr = true })

                -- Actions
                map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                map("n", "<leader>hS", gs.stage_buffer)
                map("n", "<leader>hu", gs.undo_stage_hunk)
                map("n", "<leader>hR", gs.reset_buffer)
                map("n", "<leader>hp", gs.preview_hunk)
                map("n", "<leader>hb", function() gs.blame_line { full = true } end)
                map("n", "<leader>tb", gs.toggle_current_line_blame)
                map("n", "<leader>hd", gs.diffthis)
                map("n", "<leader>hD", function() gs.diffthis("~") end)
                map("n", "<leader>td", gs.toggle_deleted)

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
            end
        }
        -- }}}
    },
    {
        'polarmutex/git-worktree.nvim',
        version = '^2',
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local Hooks = require("git-worktree.hooks")
            local config = require('git-worktree.config')
            local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

            Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
                vim.notify("Moved from " .. prev_path .. " to " .. path)
                update_on_switch(path, prev_path)
            end)

            Hooks.register(Hooks.type.DELETE, function()
                vim.cmd(config.update_on_change_command)
            end)
        end
    }
}
