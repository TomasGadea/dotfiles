return {
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = { 
                "python", 
                "c", 
                "lua", 
                "vim", 
                "vimdoc", 
                "query", 
                "elixir", 
                "heex", 
                "javascript", 
                "html" 
            },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
