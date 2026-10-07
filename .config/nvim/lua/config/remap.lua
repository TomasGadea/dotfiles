vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("v", "<leader>P", '"+P')

vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")



-- move between splits, and to the next tmux/herdr pane at the edge
-- (herdr side: .config/herdr/plugins/vim-navigator)
local function navigate(wincmd, tmux_cmd, herdr_direction)
  return function()
    if vim.env.TMUX then
      vim.cmd(tmux_cmd)
      return
    end
    local win = vim.api.nvim_get_current_win()
    vim.cmd("wincmd " .. wincmd)
    if win == vim.api.nvim_get_current_win() and vim.env.HERDR_PANE_ID then
      vim.system({ vim.env.HERDR_BIN_PATH or "herdr", "pane", "focus",
        "--pane", vim.env.HERDR_PANE_ID, "--direction", herdr_direction })
    end
  end
end
vim.keymap.set("n", "<C-h>", navigate("h", "TmuxNavigateLeft", "left"))
vim.keymap.set("n", "<C-l>", navigate("l", "TmuxNavigateRight", "right"))
vim.keymap.set("n", "<C-k>", navigate("k", "TmuxNavigateUp", "up"))
vim.keymap.set("n", "<C-j>", navigate("j", "TmuxNavigateDown", "down"))
