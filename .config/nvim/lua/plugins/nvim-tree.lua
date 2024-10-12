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
        })
        vim.keymap.set("n", "<C-n>", ":NvimTreeFindFileToggle<CR>")
        vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]

    end,
}
