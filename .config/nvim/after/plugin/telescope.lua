local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
        file_ignore_patterns = {
            ".git/",
            ".venv/",
            "mypy_cache/",
            "ruff_cache/",
            ".idea/"
        }
    })
end, {})

vim.keymap.set('n', '<C-p>', builtin.git_files, {})

vim.keymap.set('n', '<leader>ps', function()
    builtin.live_grep({
        additional_args = function()
            return {
                "--hidden",
                "--no-ignore",
                "--glob", "!**/.git/*",
                "--glob", "!**/.venv/*",
                "--glob", "!**/mypy_cache/*",
                "--glob", "!**/ruff_cache/*",
                "--glob", "!**/.idea/*"
            }
        end
    })
end, {})
