-- Telescope file finder + live grep.
--
-- Indexing strategy (the "VSCode-fast" sweetspot):
--   * RESPECT .gitignore — this is what keeps node_modules/build/cache dirs out
--     and makes search fast. (The old config used no_ignore/--no-ignore, which
--     disabled .gitignore and indexed "hella files".)
--   * --hidden so dotfiles are considered.
--   * Re-include genuinely-useful gitignored files (.env, .envrc, ...) via the
--     stowed ~/.rgignore, which ripgrep reads with higher precedence than
--     .gitignore. Edit that file to tweak what comes back.
--   * The excludes below are a backstop for directories opened OUTSIDE a git repo
--     (where there is no .gitignore to honor) and for the always-noisy .git dir.

-- Directories we never want in results (applied as ripgrep --glob excludes).
local rg_excludes = {
  '.git',
  'node_modules',
  '.venv',
  '__pycache__',
  '.mypy_cache',
  '.ruff_cache',
  '.pytest_cache',
  '.idea',
  '.cache',
  'dist',
  'build',
  'target',
}

-- Turn the exclude list into the ripgrep `--glob !**/<dir>/*` argument pairs.
local function exclude_globs()
  local args = {}
  for _, dir in ipairs(rg_excludes) do
    table.insert(args, '--glob')
    table.insert(args, '!**/' .. dir .. '/*')
  end
  return args
end

-- `rg --files ...` for find_files: respects .gitignore + ~/.rgignore, shows
-- hidden files, drops the noisy dirs above.
local function find_command()
  local cmd = { 'rg', '--files', '--hidden' }
  for _, a in ipairs(exclude_globs()) do
    table.insert(cmd, a)
  end
  return cmd
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = 'Telescope',
  keys = {
    {
      '<leader>pf',
      function()
        require('telescope.builtin').find_files({
          find_command = find_command(),
        })
      end,
      desc = 'Find Files (gitignore-aware + .rgignore)'
    },
    {
      '<C-p>',
      function()
        require('telescope.builtin').git_files()
      end,
      desc = 'Git Files'
    },
    {
      '<leader>ps',
      function()
        require('telescope.builtin').live_grep({
          additional_args = function()
            -- live_grep already respects .gitignore; just add --hidden and the
            -- same dir excludes. ~/.rgignore re-includes .env etc.
            local args = { '--hidden' }
            for _, a in ipairs(exclude_globs()) do
              table.insert(args, a)
            end
            return args
          end,
        })
      end,
      desc = 'Live Grep (gitignore-aware + .rgignore)'
    }
  },
  config = function()
    require('telescope').setup({})
  end,
}
