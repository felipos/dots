vim.cmd "set fillchars+=vert:│" -- necessary to codesmell_dark theme
local colorscheme = "codesmell_dark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
