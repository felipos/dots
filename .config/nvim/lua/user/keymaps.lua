local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

--Remap comma as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Unbind keys
keymap("i", "<C-j>", "<Nop>", opts)
keymap("i", "<C-k>", "<Nop>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- File Tree
keymap("n", "<leader>3", "<cmd>lua require'nvim-tree'.toggle(false, true)<cr>", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Do not overwrite the yank register
keymap("v", "p", '"_dP', opts)

-- Save files
keymap("n", "W", ":wa!<CR>", opts)

-- Just exit without asking questions
keymap("n", "<C-E>", ":qa!<CR>", opts)

-- Close current buffer
keymap("n", "E", ":bp | sp | bn | bd <CR>", opts)

-- File searching
keymap("n", "<leader>f", "<cmd>Telescope frecency theme=ivy<cr>", opts)
keymap("n", "<leader>g", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>,", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>c", "<cmd>Telescope command_history<cr>", opts)
keymap("n", "<leader>r", "<cmd>Telescope registers<cr>", opts)
keymap("n", "<leader>s", "<cmd>Telescope spell_suggest<cr>", opts)
keymap("n", "<leader>k", "<cmd>Telescope keymaps<cr>", opts)
keymap("n", "<leader>t", "<cmd>lua require'telescope.builtin'.colorscheme{}<cr>", opts)


-- Code formating
keymap("n", "<leader>p", ":Format<cr>", opts)
