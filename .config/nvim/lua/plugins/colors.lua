return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false, -- load immediately
    config = function()
      require("rose-pine").setup({
        --- optional default variant:
        variant = "rose", -- "moon" (dark), "dawn" (light), or "rose" (default dark)
        highlight_groups = {
          Visual = { blend = 40 }, -- bright yellow background
        }

      })
      vim.cmd("colorscheme rose-pine")
    end,
  },
}
