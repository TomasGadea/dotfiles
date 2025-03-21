vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "88"
vim.opt.guicursor = ""
vim.opt.splitright = true
vim.opt.cursorline = true
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true , silent = true })
vim.opt.foldmethod = "indent"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldnestmax = 4
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal indentkeys-=<:>"
})
