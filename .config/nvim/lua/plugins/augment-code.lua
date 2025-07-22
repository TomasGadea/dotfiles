return {
    'augmentcode/augment.vim',
    name = 'augment',
    config = function()
      vim.g.augment_workspace_folders = { vim.fn.getcwd() }
      vim.keymap.set("n", "<leader>ac", ":Augment chat<CR>", { desc = "Augment chat" })
      vim.keymap.set("v", "<leader>ac", ":Augment chat<CR>", { desc = "Augment chat" })
      vim.keymap.set("n", "<leader>an", ":Augment chat-new<CR>", { desc = "Augment new chat" })
      vim.keymap.set("n", "<leader>at", ":Augment chat-toggle<CR>", { desc = "Augment toggle chat" })
    end,
}
