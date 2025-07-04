-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = { "javascript", "typescript", "python", "sql", "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "dockerfile"},
--   sync_install = false,
--   auto_install = true,
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = false,
--   },
-- }




return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "javascript", "typescript", "python", "sql",
        "c", "cpp", "lua", "vim", "vimdoc",
        "query", "markdown", "markdown_inline", "dockerfile"
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end,
}

