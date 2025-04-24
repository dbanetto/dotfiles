-- Defaults
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess:append('c')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Set default capabilities
vim.lsp.config('*', { capabilities = capabilities })

-- GoLang
vim.lsp.config('gopls', {
    settings = {
        ['gopls'] = {
            env = {
                GOPACKAGESDRIVER = "./tools/gopackagesdriver.sh"
            },
            directoryFilters = {
                "-bazel-bin",
                "-bazel-out",
                "-bazel-testlogs",
                "-bazel-k8s",
                "-bazel-infrastructure",
            },
        },
    },
})

vim.lsp.config('lua_ls', {
    settings = {
        ['Lua'] = {
            telemetry = {
                enable = false,
            },
        }
    },
})

vim.lsp.config('jsonnet_ls', {
    settings = {
        ['jsonnet_ls'] = {
            formatting = {
                -- StringStyle = "double",
            },
        }
    },
})

vim.lsp.config('starpls', {
    cmd = { 'starpls', 'server', '--experimental_infer_ctx_attributes', '--experimental_enable_label_completions' },
    filetypes = { 'bzl', },
    root_markers = { 'WORKSPACE', 'WORKSPACE.bazel', 'MODULE.bazel' },
})

-- Autocommands
-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)

--         if client:supports_method('textDocument/completion') then
--             vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--         end
--     end,
-- })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client:supports_method('textDocument/documentHighlight') then
            local autocmd = vim.api.nvim_create_autocmd
            local augroup = vim.api.nvim_create_augroup('lsp_highlight', { clear = false })

            vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup })

            autocmd({ 'CursorHold' }, {
                group = augroup,
                buffer = args.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            autocmd({ 'CursorMoved' }, {
                group = augroup,
                buffer = args.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})
