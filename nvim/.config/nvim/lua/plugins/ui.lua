return {
    {
        -- lualine {{{
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diagnostics" },
                lualine_c = { "%f" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "%F" },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_a = { 'buffers' },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'oil', 'aerial', 'tabs' }
            },
            -- Per split
            winbar = {
                lualine_a = { { "navic", color_correction = "dynamic" } },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            extensions = {}
        },
        -- }}}
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require "alpha.themes.startify".config)
        end
    },
    -- {
    --     -- barbar {{{
    --     'romgrk/barbar.nvim',
    --     opts = {
    --         -- Disable animations
    --         animation = false,
    --         -- Excludes buffers from the tabline
    --         exclude_ft = { 'netrw' },
    --         exclude_name = { 'package.json' },
    --     },
    --     config = function()
    --         local opts = { noremap = true, silent = true }
    --         -- Move to previous/next
    --         vim.keymap.set('n', '[b', '<Cmd>BufferPrevious<CR>', opts)
    --         vim.keymap.set('n', ']b', '<Cmd>BufferNext<CR>', opts)

    --         -- Wipeout buffer
    --         --                 :BufferWipeout
    --         -- Close commands
    --         --                 :BufferCloseAllButCurrent
    --         --                 :BufferCloseAllButPinned
    --         --                 :BufferCloseAllButCurrentOrPinned
    --         --                 :BufferCloseBuffersLeft
    --         --                 :BufferCloseBuffersRight
    --         -- Magic buffer-picking mode
    --         vim.keymap.set('n', '<Space>bd', '<Cmd>BufferWipeout<CR>', opts)
    --         vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
    --     end
    --     -- }}}
    -- },
    {
        "samjwill/nvim-unception",
        init = function()
            -- Optional settings go here!
            -- e.g.) vim.g.unception_open_buffer_in_new_tab = true
        end
    }
}
