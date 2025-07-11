return {
    {
        "SethBarberee/challenger-deep.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000,
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            compile = true,   -- enable compiling the colorscheme
            undercurl = true, -- enable undercurls
            commentStyle = { italic = true },
            functionStyle = {},
            keywordStyle = { italic = true },
            statementStyle = { bold = true },
            terminalColors = true, -- define vim.g.terminal_color_{0,17}
            colors = {             -- add/modify theme and palette colors
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            theme = "wave",    -- Load "wave" theme
            background = {     -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus"
            },
        },
        config = function(_, opts)
            require("kanagawa").setup(opts) -- calling setup is optional
            vim.cmd [[colorscheme kanagawa]]
        end,
    },
}
