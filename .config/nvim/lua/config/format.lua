local method = ":silent !"

local python_formatters = { "ruff format", "ruff check --fix" }
local shell_formatters = { "shfmt -w -i 4 -ci" }

local all_formatters = {
    python = python_formatters,
    sh = shell_formatters,
}

local function format_file()
    local file_path = vim.api.nvim_buf_get_name(0)
    local file_type = vim.bo.filetype

    local formatters = all_formatters[file_type] or {}

    vim.cmd("silent write!")

    if #formatters == 0 then
        print("No formatter available for " .. file_type .. ".")
    end

    for _, formatter in ipairs(formatters) do
        vim.cmd(method .. formatter .. " " .. file_path)
    end

    vim.cmd("edit!")
end

vim.api.nvim_create_user_command("FormatFile", format_file, {})

vim.api.nvim_set_keymap("n", "<leader>F", ":FormatFile<cr>", { noremap = true, silent = true })
