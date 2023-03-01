local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--Remap comma as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Better window navigation
keymap("n", "<C-k>", "<cmd> call VSCodeNotify('workbench.action.navigateUp') <cr>", opts)
keymap("n", "<C-j>", "<cmd> call VSCodeNotify('workbench.action.navigateDown') <cr>", opts)
keymap("n", "<C-h>", "<cmd> call VSCodeNotify('workbench.action.navigateLeft') <cr>", opts)
keymap("n", "<C-l>", "<cmd> call VSCodeNotify('workbench.action.navigateRight') <cr>", opts)

--[[ -- Resize windows ]]
--[[ keymap("n", "<C-Up>", ":resize +2<CR>", opts) ]]
--[[ keymap("n", "<C-Down>", ":resize -2<CR>", opts) ]]
--[[ keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts) ]]
--[[ keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts) ]]

-- Navigate buffers
keymap("n", "<S-l>", "<cmd> call VSCodeNotify('workbench.action.nextEditor') <cr>", opts)
keymap("n", "<S-h>", "<cmd> call VSCodeNotify('workbench.action.previousEditor') <cr>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Do not overwrite the yank register
keymap("v", "p", '"_dP', opts)

-- Save files
keymap("n", "W", "<cmd> call VSCodeNotify('workbench.action.files.save') <cr>", opts)

-- Just exit without asking questions
keymap("n", "E", "<cmd> call VSCodeNotify('workbench.action.closeActiveEditor') <cr>", opts)

-- File searching
keymap("n", "<leader>f", "<cmd> call VSCodeNotify('workbench.action.quickOpen') <cr>", opts)
keymap("n", "<leader>g", "<cmd> call VSCodeNotify('workbench.action.findInFiles') <cr>", opts)

-- Show VSCode commands
keymap("n", "<leader>c", "<cmd> call VSCodeNotify('workbench.action.showCommands') <cr>", opts)

--[[ -- Code formating ]]
--[[ keymap("n", "<leader>p", ":Format<cr>", opts) ]]

-- Buffers
keymap("n", "<leader>v", "<cmd> call VSCodeNotify('workbench.action.splitEditorRight') <cr>", opts)
keymap("n", "<leader>h", "<cmd> call VSCodeNotify('workbench.action.splitEditorDown') <cr>", opts)
