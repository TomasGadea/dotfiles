return {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        telescope.setup({
            defaults = {
                file_ignore_patterns = { "%.git/" }, -- Ignore files from the .git folder
            },
            pickers = {
                live_grep = {
                    additional_args = function(opts)
                        return { "--hidden", "--glob", "!.git/*" } -- Include hidden files but exclude .git folder
                    end,
                },
            },
        })
        vim.keymap.set('n', '<leader>pf', function()
            builtin.find_files({
                hidden = true, -- Include hidden files
            })
        end, {})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
    end
}
