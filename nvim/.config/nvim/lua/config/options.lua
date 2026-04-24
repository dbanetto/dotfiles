-- General Settings {{{

-- Leader
vim.g.mapleader = " "

-- Window settings
vim.opt.title = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmode = false

-- Spelling
vim.opt.spelllang = 'en'

-- Windows
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Buffer
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.showmode = false

-- Mouse
vim.opt.mouse = 'n'

-- Swap
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Indent
vim.opt.autoindent = true
vim.opt.copyindent = true

-- Tab
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Warp
vim.opt.display = 'lastline'
vim.opt.formatoptions = 'tcroql'
vim.opt.linebreak = true
vim.opt.joinspaces = false
vim.opt.wrap = true
vim.opt.textwidth = 0

-- Folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 4

-- Undo file
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 1000

-- List characters
vim.opt.listchars = { tab = '▸ ', eol = '¬', trail = '⋅', extends = '❯', precedes = '❮' }
vim.opt.showbreak = '↪'

-- diff
table.insert(vim.opt.diffopt, "filter")

-- Wildcard
vim.opt.wildmenu = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.magic = true
table.insert(vim.opt.matchpairs, "<:>")
table.insert(vim.opt.path, "**")
vim.opt.matchtime = 2
vim.opt.showmatch = true
vim.opt.smartcase = true

-- Ignore
vim.opt.wildignore = {
    "*.class",
    "*.gem",
    "*.o",
    "*.obj",
    "*.out",
    "*.rar",
    "*.rbc",
    "*.rbo",
    "*.swp",
    "*.tar.bz2",
    "*.tar.gz",
    "*.tar.xz",
    "*.zip",
    "*/.bundle/*",
    "*/.kitchen/*",
    "*/.sass-cache/*",
    "*/.vagrant/*",
    "*/node_modules/*",
    "*/tmp/cache/assets/*/sass/*",
    "*/tmp/cache/assets/*/sprockets/*",
    "*/tmp/librarian/*",
    "*/vendor/cache/*",
    "*/vendor/cookbooks/*",
    "*/vendor/gems/*",
    "*~",
    "._*",
    ".git",
    ".svn",
}

-- show result of command as you go
vim.opt.inccommand = 'nosplit'

-- Ensure sign column is present
vim.opt.signcolumn = 'yes'

-- Enable .editorconfig file support
vim.g.editorconfig = true

-- Diagnostics
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

--- }}}
