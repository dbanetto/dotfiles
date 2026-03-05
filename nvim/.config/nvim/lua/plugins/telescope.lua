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
            require('telescope').load_extension('git_worktree')

            local builtin = require("telescope.builtin")
            -- Add leader shortcuts
            vim.keymap.set("n", "<leader><space>", builtin.resume, { desc = "Resume telescope picker" })
            vim.keymap.set("n", "<leader>f-", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "Find files (git)" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Select buffers" })
            vim.keymap.set("n", "zf", builtin.spell_suggest, { desc = "Show spelling suggestions" })

            -- Helps
            vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Open quickfix picker" })

            -- LSP
            vim.keymap.set("n", "glr", builtin.lsp_references, { desc = "Search LSP references" })
            vim.keymap.set("n", "gli", builtin.lsp_incoming_calls, { desc = "Search LSP incoming calls" })
            vim.keymap.set("n", "glo", builtin.lsp_outgoing_calls, { desc = "Search out-going calls" })
            vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "List document dymbols from LSP" })

            -- Git git_worktree
            vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Select git branches" })
            vim.keymap.set("n", "<leader>gw", "<cmd>Telescope git_worktree<CR>", { desc = "Select git workspace" })
            vim.keymap.set("n", "<leader>gW", "<cmd>Telescope create_git_worktree<CR>", { desc = "Create git workspace" })
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
    }
}
