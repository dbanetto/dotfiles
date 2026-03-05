return {
    {
        "olimorris/codecompanion.nvim",
        opts = function()
            local settings = require('config.ai')

            vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>",
                { noremap = true, silent = true })
            vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

            -- Expand 'cc' into 'CodeCompanion' in the command line
            vim.cmd([[cab cc CodeCompanion]])

            return {
                display = {
                    chat = {
                        icons = {
                            chat_context = "📎️", -- You can also apply an icon to the fold
                        },
                        fold_context = true,
                    },
                },
                strategies = settings.strategies,
                adapters = settings.adapters,
                mcp = settings.mcp,
            }
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "HakonHarnes/img-clip.nvim",
        opts = {
            filetypes = {
                codecompanion = {
                    prompt_for_file_name = false,
                    template = "[Image]($FILE_PATH)",
                    use_absolute_path = true,
                },
            },
        },
    },
}
