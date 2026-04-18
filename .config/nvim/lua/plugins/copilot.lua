return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      keymap = {
        accept = '<Tab>',
        dismiss = '<C-]>',
        next = '<M-]>',
        prev = '<M-[>',
      },
    },
    copilot_node_command = 'node',
  },
}
