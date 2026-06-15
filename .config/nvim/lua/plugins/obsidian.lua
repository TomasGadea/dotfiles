return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
      {
        name = "obsidian-second-brain",
        path = "~/Documents/logs/obsidian-second-brain",
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
