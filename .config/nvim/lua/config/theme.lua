-- Theme loader: reads theme from ~/.local/state/theme and applies it.
-- Called on startup and via :ChangeTheme user command.

local M = {}

local theme_file = vim.fn.expand("~/.local/state/theme")

-- Map theme names (from changetheme shell function) to Neovim colorschemes
local theme_map = {
  latte = { plugin = "catppuccin", colorscheme = "catppuccin-latte", background = "light" },
  frappe = { plugin = "catppuccin", colorscheme = "catppuccin-frappe", background = "dark" },
  macchiato = { plugin = "catppuccin", colorscheme = "catppuccin-macchiato", background = "dark" },
  mocha = { plugin = "catppuccin", colorscheme = "catppuccin-mocha", background = "dark" },
  solarized = { plugin = "nvim-solarized-lua", colorscheme = "solarized", background = "light" },
  rosepine = { plugin = "rose-pine", colorscheme = "rose-pine-dawn", background = "light" },
  gruvbox = { plugin = "gruvbox-material", colorscheme = "gruvbox-material", background = "light" },
}

-- Default if no theme file exists
local default_theme = "rosepine"

function M.load()
  local theme_name = default_theme

  local f = io.open(theme_file, "r")
  if f then
    local content = f:read("*l")
    f:close()
    if content and content ~= "" then
      theme_name = vim.trim(content)
    end
  end

  local theme = theme_map[theme_name]
  if not theme then
    vim.notify("Unknown theme: " .. theme_name .. ", falling back to " .. default_theme, vim.log.levels.WARN)
    theme = theme_map[default_theme]
  end

  vim.opt.background = theme.background

  -- ensure the plugin is loaded (they are lazy = true)
  local ok_load = pcall(function()
    require("lazy").load({ plugins = { theme.plugin } })
  end)
  if not ok_load then
    vim.notify("Failed to load plugin: " .. theme.plugin, vim.log.levels.ERROR)
    return
  end

  local ok, err = pcall(vim.cmd, "colorscheme " .. theme.colorscheme)
  if not ok then
    vim.notify("Failed to set colorscheme: " .. tostring(err), vim.log.levels.ERROR)
  end
end

-- User command so changetheme can trigger a reload in running instances
vim.api.nvim_create_user_command("ChangeTheme", function()
  M.load()
end, { desc = "Reload theme from ~/.local/state/theme" })

return M
