return {
    {
        "stevearc/oil.nvim",
        lazy = false,
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
}
