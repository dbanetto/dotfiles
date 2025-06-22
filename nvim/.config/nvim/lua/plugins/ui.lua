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
                always_divide_middle = true,
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
            winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {}
            },
            extensions = { 'oil' }
        },
        -- }}}
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require "alpha.themes.startify".config)
        end
    },
    {
        -- barbar {{{
        'romgrk/barbar.nvim',
        opts = {
            -- Disable animations
            animation = false,
            -- Excludes buffers from the tabline
            exclude_ft = { 'netrw', 'oil', 'help' },
            exclude_name = { 'package.json' },
        },
        config = function()
            local opts = { noremap = true, silent = true }
            -- Move to previous/next
            vim.keymap.set('n', '[b', '<Cmd>BufferPrevious<CR>', opts)
            vim.keymap.set('n', ']b', '<Cmd>BufferNext<CR>', opts)

            -- Wipeout buffer
            --                 :BufferWipeout
            -- Close commands
            --                 :BufferCloseAllButCurrent
            --                 :BufferCloseAllButPinned
            --                 :BufferCloseAllButCurrentOrPinned
            --                 :BufferCloseBuffersLeft
            --                 :BufferCloseBuffersRight
            -- Magic buffer-picking mode
            vim.keymap.set('n', '<Space>bd', '<Cmd>BufferWipeout<CR>', opts)
            vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
        end
        -- }}}
    },
    {
        "samjwill/nvim-unception",
        init = function()
            -- Optional settings go here!
            -- e.g.) vim.g.unception_open_buffer_in_new_tab = true
        end
    },
    {
        "stevearc/oil.nvim",
        lazy = false,
        opts = {
            delete_to_trash = true,
            keymaps = {
                ["q"] = { "actions.close", mode = "n" },
            },
        },
        keys = {
            { "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "tpope/vim-surround",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        'nvim-orgmode/orgmode',
        dependencies = {
            'akinsho/org-bullets.nvim',
            'danilshvalov/org-modern.nvim',
            'nvim-orgmode/telescope-orgmode.nvim',
        },
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            local Menu = require("org-modern.menu")
            require("telescope").load_extension("orgmode")

            vim.keymap.set('n', '<leader>ofh', require("telescope").extensions.orgmode.search_headings)
            vim.keymap.set('n', '<leader>off', function()
                    require('telescope.builtin').find_files({
                        cwd = '~/Library/Mobile Documents/com~apple~CloudDocs/org',
                    })
                end,
                { desc = 'Telescope find org files' })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'org',
                group = vim.api.nvim_create_augroup('orgmode_telescope_nvim', { clear = true }),
                callback = function()
                    vim.keymap.set('n', '<leader>or', require('telescope').extensions.orgmode.refile_heading)
                    vim.keymap.set("n", "<leader>oil", require("telescope").extensions.orgmode.insert_link)
                end,
            })

            -- TODO: Do host detection for orgfile location
            local syncDir = '~/Library/Mobile Documents/com~apple~CloudDocs/org'

            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = { '~/orgfiles/**/*', syncDir .. '/**/*' },
                org_default_notes_file = '~/orgfiles/refile.org',
                org_capture_templates = {
                    n = {
                        description = 'Note',
                        template = '* %? :note:\n  %u\n  '
                    },
                    l = {
                        description = 'Learning',
                        template = '* %? :learning:\n  %u\n  Reference: [[file:%F]]\n'
                    },
                    t = {
                        description = 'Task',
                        template = '* TODO %? \n  %u\n  '
                    },
                    d = {
                        description = 'Deadline',
                        template = '* TODO %?\n  DEADLINE: %^t\n  %u'
                    },
                    s = {
                        description = 'Schedule',
                        template = '* %?\n  SCHEDULED: %^t\n  %u'
                    },
                    m = {
                        description = 'Meeting',
                        template =
                        '* %?\n  SCHEDULED: %^t\n  %u\n** Attendes\n** Notes\n\t\n** Actions\n - [ ] Take notes\n'
                    },
                    j = {
                        description = 'Journal',
                        template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
                        target = syncDir .. '/personal/journal.org'
                    },
                },
                mappings = {
                    global = {
                        org_agenda = { 'gA', '<Leader>oa' },
                        org_capture = { 'gC', '<Leader>oc' },
                    },
                    agenda = {
                        org_agenda_refile = 'gor',
                    },
                    note = {
                        org_note_finalize = '<Leader>w',
                        org_note_kill = 'Q'
                    },
                    org = {
                        org_refile = 'gor',
                    },
                },
                ui = {
                    menu = {
                        handler = function(data)
                            Menu:new({
                                window = {
                                    margin = { 1, 0, 1, 0 },
                                    padding = { 0, 1, 0, 1 },
                                    title_pos = "center",
                                    border = "single",
                                    zindex = 1000,
                                },
                                icons = {
                                    separator = "➜",
                                },
                            }):open(data)
                        end,
                    },
                },
            })

            --Setup org-bullets
            require('org-bullets').setup()
        end,
    },
}
