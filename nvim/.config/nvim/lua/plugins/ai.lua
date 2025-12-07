return {
    {
        "olimorris/codecompanion.nvim",
        opts = function()
            local settings = require('config.ai')

            vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
            vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>",
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
                extensions = {
                    mcphub = {
                        callback = "mcphub.extensions.codecompanion",
                        opts = {
                            make_vars = true,
                            make_slash_commands = true,
                            show_result_in_chat = true
                        }
                    }
                },
                strategies = settings.strategies,
                adapters = settings.adapters,
                -- v18 upgrade warning
                ignore_warnings = true,
            }
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "echasnovski/mini.diff",
        config = function()
            local diff = require("mini.diff")
            diff.setup({
                -- Disabled by default
                source = diff.gen_source.none(),
            })
        end,
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
    {
        "ravitemer/mcphub.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
        config = function()
            require("mcphub").setup({
                use_bundled_binary = true, -- Use local `mcp-hub` binary
                extensions = {
                    avante = {
                        make_slash_commands = true, -- make /slash commands from MCP server prompts
                    }
                }
            })
        end,
    },
}
