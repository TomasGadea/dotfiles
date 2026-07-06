return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- The `main` branch (required for Neovim 0.12+) has a different API than
    -- `master`: there is no `configs.setup` with `ensure_installed`/`highlight`.
    -- Parsers are installed explicitly, and highlighting is started per-buffer.
    require('nvim-treesitter').install {
      'javascript', 'typescript', 'tsx', 'python', 'sql',
      'c', 'cpp', 'lua', 'vim', 'vimdoc',
      'query', 'markdown', 'markdown_inline', 'dockerfile', 'jinja',
      'yaml', 'json', 'bash',
    }

    -- Enable treesitter highlighting on any buffer whose filetype has a parser.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        -- `vim.treesitter.start` derives the language from the filetype; wrap in
        -- pcall so files without an installed parser fall back silently.
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
