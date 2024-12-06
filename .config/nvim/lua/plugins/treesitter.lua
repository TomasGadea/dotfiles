return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = { 
                "python", 
                "c", 
                "cpp",
                "lua", 
                "vim", 
                "vimdoc", 
                "query", 
                "elixir", 
                "heex", 
                "javascript", 
                "html",
                "css",
                "svelte"
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
