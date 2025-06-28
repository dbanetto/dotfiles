return {
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

            local orgdir = '~/orgfiles'

            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = { orgdir .. '/**/*' },
                org_default_notes_file = '~/orgfiles/refile.org',
                org_startup_indented = true,
                org_todo_keywords = { 'TODO', 'NEXT', 'WAITING', '|', 'DONE', 'DELEGATED' },
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
                        target = orgdir .. '/personal/journal.org'
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
