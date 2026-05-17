return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('nvim-treesitter').setup {
      ensure_installed = {
        "javascript", "typescript", "python", "sql",
        "c", "cpp", "lua", "vim", "vimdoc",
        "query", "markdown", "markdown_inline", "dockerfile", "jinja",
      },
      sync_install = false,
      auto_install = true,
    }
  end,
}

