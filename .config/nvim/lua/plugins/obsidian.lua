local vault = "~/Documents/logs/obsidian-second-brain"

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  -- obsidian.nvim fails at startup if no workspace exists, so load it only where the vault is
  cond = vim.fn.isdirectory(vim.fn.expand(vault)) == 1,
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
      {
        name = "obsidian-second-brain",
        path = vault,
      },
    },
    footer = {
      enabled = false, -- turn it off
      separator = false, -- turn it off
      -- separator = "", -- insert a blank line
      format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars", -- works like the template system
      -- format = "({{backlinks}} backlinks)", -- limit to backlinks
      hl_group = "@property", -- Use another hl group
    },
  },
}
