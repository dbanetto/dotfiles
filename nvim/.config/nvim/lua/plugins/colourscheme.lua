return {
    {
        "SethBarberee/challenger-deep.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function(_, _)
            vim.cmd [[colorscheme challenger-deep]]
        end,
    },
    -- {
    --     "tiagovla/tokyodark.nvim",
    --     opts = {
    --         gamma = 1.00,                         -- adjust the brightness of the theme
    --         styles = {
    --             comments = { italic = false },    -- style for comments
    --             keywords = { italic = false },    -- style for keywords
    --             identifiers = { italic = false }, -- style for identifiers
    --             functions = {},                   -- style for functions
    --             variables = {},                   -- style for variables
    --         },
    --     },
    --     config = function(_, opts)
    --         require("tokyodark").setup(opts) -- calling setup is optional
    --         vim.cmd [[colorscheme tokyodark]]
    --     end,
    -- },
}
