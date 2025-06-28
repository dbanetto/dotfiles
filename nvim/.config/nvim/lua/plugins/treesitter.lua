return {
    {
        "nvim-treesitter/nvim-treesitter",
        main = "nvim-treesitter.configs",
        build = ":TSUpdate",
        opts = {
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = {
                "rust",
                "terraform",
                "go",
                "lua",
                "vim",
                "gitcommit",
                "query",
            },
            ignore_install = { 'org' },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>ts",
                    node_incremental = "<C-t>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        -- Built-in captures.
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
                },
            },
        }
    },
    {
        -- nvim-treesitter-textobjects {{{
        "nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        --- }}}
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            enable = true,
            mode = "topline",
            separator = '-',
            line_numbers = true
        }
    },
    {
        "cshuaimin/ssr.nvim",
        keys = { { "<leader>sr", function() require("ssr").open() end, mode = { "n", "x", "v" }, desc = "Symbols Outline" } },
        lazy = true
    },
}
