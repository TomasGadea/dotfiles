return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            filters = {
                dotfiles = false,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                    window_picker = {
                        enable = false, -- Ensure the window picker doesn't interfere
                    },
                },
            },
        })
        vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>")
        vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]

    end,
}
