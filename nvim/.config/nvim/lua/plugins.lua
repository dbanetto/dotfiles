-- Lazy.nvim Bootstrap {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--  }}}

require("lazy").setup({
  {
    "challenger-deep-theme/vim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme challenger_deep]])
    end,
  },
  {
    "stevearc/oil.nvim",
    opts = {
      delete_to_trash = true,
    },
    keys = {
      { "-", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require "alpha.themes.startify".config)
    end
  },
  {
    -- barbar {{{
    "romgrk/barbar.nvim",
    opts = {
      -- Disable animations
      animation = false,
      -- Excludes buffers from the tabline
      exclude_ft = { "netrw" },
      exclude_name = { "package.json" },
    },
    config = function()
      local opts = { noremap = true, silent = true }
      -- Move to previous/next
      vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
      vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
      vim.keymap.set("n", "[b", "<Cmd>BufferPrevious<CR>", opts)
      vim.keymap.set("n", "]b", "<Cmd>BufferNext<CR>", opts)

      -- Re-order to previous/next
      vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
      vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
      -- Goto buffer in position...
      vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
      vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
      vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
      vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
      vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
      vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
      vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
      vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
      vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
      vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
      -- Pin/unpin buffer
      vim.keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
      -- Close buffer
      vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      -- Magic buffer-picking mode
      vim.keymap.set("n", "<Space>bd", "<Cmd>BufferWipeout<CR>", opts)
      vim.keymap.set("n", "<C-p>", "<Cmd>BufferPick<CR>", opts)
      -- Sort automatically by...
      vim.keymap.set("n", "<Space>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
      vim.keymap.set("n", "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
      vim.keymap.set("n", "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)
    end
    -- }}}
  },
  { "williamboman/mason.nvim",           opts = {} },
  { "williamboman/mason-lspconfig.nvim", opts = {} },
  {
    -- LSP {{{
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format { async = false }
          end
        })

        -- Disablied as it causes a pile up of errors
        -- vim.api.nvim_create_autocmd("BufWritePre", {
        --   pattern = "*.go",
        --   callback = function()
        --     vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
        --   end
        -- })

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>lwa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>lwr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>lwl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      -- LSP settings
      local nvim_lsp = require "lspconfig"
      -- Set up lspconfig.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Enable the following language servers
      local servers = {
        "pyright",
        ["gopls"] = {
          gopls = {
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
          }
        },
        "tsserver",
        "tflint",
        ["lua_ls"] = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files and plugins
              library = { vim.env.VIMRUNTIME },
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
        ["jsonnet_ls"] = {
          formatting = {
            StringStyle = "double",
          },
        },
      }

      for k, lsp in pairs(servers) do
        if type(k) == "string" then
          nvim_lsp[k].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = lsp,
          }
        else
          nvim_lsp[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
          }
        end
      end
    end
    -- }}}
  },
  {
    -- rust-tools {{{
    "simrat39/rust-tools.nvim",
    ft = "rust",
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
          end
        },
      })
    end
    -- }}}
  },
  {
    -- Telescope {{{
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
    },
    config = function()
      local builtin = require("telescope.builtin")
      -- Add leader shortcuts
      vim.keymap.set("n", "<leader><space>", builtin.resume, {})
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>fz", builtin.spell_suggest, {})
      vim.keymap.set("n", "<leader>fs", builtin.treesitter, {})

      -- LSP
      vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {})
      vim.keymap.set("n", "<leader>li", builtin.lsp_incoming_calls, {})
      vim.keymap.set("n", "<leader>lo", builtin.lsp_outgoing_calls, {})
      vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {})
    end
    -- }}}
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
      local cmp = require "cmp"
      cmp.setup {
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
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
        },
      }
    end
    -- }}}
  },
  {
    -- nvim-treesitter {{{
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
        "query"
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
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
    --- }}}
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
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {}
    }
    -- }}}
  },
  {
    -- gitsigns {{{
    "lewis6991/gitsigns.nvim",
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.next_hunk() end)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[h", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.prev_hunk() end)
          return "<Ignore>"
        end, { expr = true })

        -- Actions
        map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hS", gs.stage_buffer)
        map("n", "<leader>hu", gs.undo_stage_hunk)
        map("n", "<leader>hR", gs.reset_buffer)
        map("n", "<leader>hp", gs.preview_hunk)
        map("n", "<leader>hb", function() gs.blame_line { full = true } end)
        map("n", "<leader>tb", gs.toggle_current_line_blame)
        map("n", "<leader>hd", gs.diffthis)
        map("n", "<leader>hD", function() gs.diffthis("~") end)
        map("n", "<leader>td", gs.toggle_deleted)

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end
    }
    -- }}}
  },
  {
    -- gitsigns {{{
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true
    -- }}}
  },
})


-- vim: set sw=2 ts=2 ft=lua expandtab fdm=marker fmr={{{,}}} fdl=0 fdls=-1:
