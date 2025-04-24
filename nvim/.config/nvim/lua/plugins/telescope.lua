return {
    {
        -- Telescope {{{
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
            },
        },
        config = function()
            local builtin = require("telescope.builtin")
            -- Add leader shortcuts
            vim.keymap.set("n", "<leader><space>", builtin.resume, {})
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
            vim.keymap.set("n", "zf", builtin.spell_suggest, {})
            vim.keymap.set("n", "<leader>fs", builtin.treesitter, {})

            -- LSP
            vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {})
            vim.keymap.set("n", "<leader>li", builtin.lsp_incoming_calls, {})
            vim.keymap.set("n", "<leader>lo", builtin.lsp_outgoing_calls, {})
            vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {})
        end
        -- }}}
    },
}
