return {
  "christoomey/vim-tmux-navigator",
  lazy = false,  -- load immediately, or true if you want lazy loading
  init = function()
    -- the <C-hjkl> mappings are in config/remap.lua (they also handle herdr)
    vim.g.tmux_navigator_no_mappings = 1
  end,
}

