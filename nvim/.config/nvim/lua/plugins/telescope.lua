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
            vim.keymap.set("n", "<leader><space>", builtin.resume, { desc = "Resume telescope picker" })
            vim.keymap.set("n", "<leader>f-", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "Find files (git)" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Select buffers" })
            vim.keymap.set("n", "zf", builtin.spell_suggest, {})

            -- Helps
            vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Open quickfix picker" })
            vim.keymap.set("n", "<leader>fm", builtin.keymaps, { desc = "Keymaps help" })
            vim.keymap.set("n", "<leader>fp", builtin.pickers, { desc = "Open previous picker menu" })

            -- LSP
            vim.keymap.set("n", "glr", builtin.lsp_references, { desc = "Search LSP references" })
            vim.keymap.set("n", "gli", builtin.lsp_incoming_calls, { desc = "Search LSP incoming calls" })
            vim.keymap.set("n", "glo", builtin.lsp_outgoing_calls, { dessc = "Search out-going calls" })
            vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "List document dymbols from LSP" })
        end
        -- }}}
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
        -- install the latest stable version
        version = "*",
        config = function()
            require("telescope").load_extension "frecency"
        end,
    },
}
