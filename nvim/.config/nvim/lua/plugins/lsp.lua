local bazel_root = { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' }

return {
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        dependencies = {
            { 'williamboman/mason.nvim', opts = {} },
        },
        build = ':MasonUpdate',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "pylyzer",
                    "gopls",
                    "lua_ls",
                    "jsonnet_ls",
                    -- "bashls",
                    "buf_ls",
                    "helm_ls",
                    "terraformls",
                    "tflint",
                    "zls",
                },
                handlers = {
                    -- Default setup for all LSP servers
                    function(server_name)
                        vim.lsp.enable(server_name)
                    end,
                    -- Custom setup for specific LSP servers
                    ['gopls'] = function()
                        vim.lsp.config('gopls', {
                            ['gopls'] = {
                                settings = {
                                    workspaceFiles = {
                                        "**/BUILD",
                                        "**/WORKSPACE",
                                        "**/*.{bzl,bazel}",
                                    },
                                    env = {
                                        GOPACKAGESDRIVER = "./tools/gopackagesdriver.sh"
                                    },
                                    directoryFilters = {
                                        "-build/bazel-bin",
                                        "-build/bazel-out",
                                        "-build/bazel-testlogs",
                                        "-build/bazel-cloud",
                                        "-bazel-k8s",
                                        "-bazel-bin",
                                        "-bazel-out",
                                        "-bazel-testlogs",
                                        "-bazel-k8s",
                                        "-bazel-infrastructure",
                                    },
                                }
                            }
                        })
                        vim.lsp.enable('gopls')
                    end,
                    ['rust_analyzer'] = function()
                        -- Let rustaceanvim handle the rust_analyzer config
                        vim.lsp.config('rust_analyzer', {})
                        vim.lsp.enable('rust_analyzer')
                    end,
                    ['starpls'] = function()
                        vim.lsp.config('starpls', {
                            cmd = {
                                'starpls',
                                'server',
                                '--experimental_infer_ctx_attributes',
                                '--experimental_enable_label_completions'
                            },
                            filetypes = { 'bzl', },
                            root_markers = { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' },
                        })
                        vim.lsp.enable('starpls')
                    end,
                    ['jsonnet_ls'] = function()
                        vim.lsp.config('jsonnet_ls', {
                            cmd = { 'jsonnet-language-server' },
                            filetypes = { 'jsonnet', 'libsonnet' },
                            single_file_support = true,
                            root_markers = bazel_root,
                        })
                        vim.lsp.enable('jsonnet_ls')
                    end,
                }
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        },
        init = function()
            vim.diagnostic.config({
                virtual_text = true,
                underline = false,
                severity_sort = true,
                -- This is the correct way to configure diagnostic signs
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '',
                        [vim.diagnostic.severity.WARN] = '',
                        [vim.diagnostic.severity.INFO] = '',
                        [vim.diagnostic.severity.HINT] = '',
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
                        [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
                        [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
                        [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
                    },
                },
            })

            -- Using `vim.fn.sign_define()` to configure diagnostic signs is deprecated in favour of the `signs` table
            -- in `vim.diagnostic.config()` but telescope.nvim still relies on it (`vim.fn.sign_getdefined(...)`
            -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/make_entry.lua#L1151)
            for name, icon in pairs({
                Error = '',
                Warn = '',
                Info = '',
                Hint = '',
            }) do
                local hl = 'DiagnosticSign' .. name
                vim.fn.sign_define(hl, { text = icon, numhl = hl })
            end

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = 'rounded',
            })

            vim.api.nvim_create_autocmd("CursorHold", {
                callback = function()
                    vim.diagnostic.open_float({
                        focusable = false,
                        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                        border = 'rounded',
                        source = true,
                        prefix = ' ',
                    })
                end
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)

                    -- Format on save
                    if client:supports_method('textDocument/formatting') then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({
                                    async = false,
                                    bufnr = args.buf,
                                    id = client.id,
                                })
                            end,
                        })
                    end

                    -- Inlay hints
                    if client:supports_method('textDocument/inlayHint') or client.server_capabilities.inlayHintProvider then
                        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
                    end
                end,
            })
        end
    },
    {
        -- nvim-cmp {{{
        "hrsh7th/nvim-cmp",
        -- load cmp on InsertEnter
        event = "InsertEnter",
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup {
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "orgmode" },
                    { name = 'render-markdown' },
                },
            }
        end
        -- }}}
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false,
        init = function()
            vim.g.rustaceanvim = {
                server = {
                    cmd = function() -- `:h rustaceanvim.mason`
                        local mason_registry = require('mason-registry')

                        if (mason_registry:is_installed('rust-analyzer')) then
                            -- This may need to be tweaked depending on the operating system.
                            local ra = mason_registry.get_package('rust-analyzer')
                            local ra_filename = ra:get_receipt():get().links.bin['rust-analyzer']
                            return { ('%s/%s'):format(ra:get_install_path(), ra_filename or 'rust-analyzer') }
                        else
                            -- global installation
                            return { 'rust-analyzer' }
                        end
                    end,
                    default_settings = {
                        ['rust-analyzer'] = {
                            cargo = {
                                targetDir = '/tmp/rust-analyzer-cargo',
                            },
                            lru = {
                                capacity = 64, -- number of syntax trees kept in memory (defaults to 128)
                            },
                        },
                    },
                },
            }
        end,
    },
}
