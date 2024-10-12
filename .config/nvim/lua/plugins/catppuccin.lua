return {
        "catppuccin/nvim",
        lazy = false,
        name = "catppuccin", 
        priority = 1000,
        --opts = {
        --      transparent_background = true,
        --},
        config = function()
            vim.cmd.colorscheme "catppuccin"
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

        end
}
