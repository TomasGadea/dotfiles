return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "javascript", "typescript", "python", "sql",
        "c", "cpp", "lua", "vim", "vimdoc",
        "query", "markdown", "markdown_inline", "dockerfile", "jinja",
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
    }
  end,
}

