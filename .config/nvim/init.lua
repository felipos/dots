if vim.g.vscode then
    -- VSCode extension
  require("user.vscode.keymaps")
  require("user.vscode.options")
else
  require("user.options")
  require("user.keymaps")
  require("user.plugins")
  require("user.colorscheme")
  require("user.cmp")
  require("user.lsp")
  require("user.telescope")
  require("user.treesitter")
  require("user.autopairs")
  require("user.comment")
  require("user.nvim-tree")
  require("user.bufferline")
  require("user.toggleterm")
  require("user.image")
  require("user.illuminate")
  require("user.focus")
  require("user.luasnip")
  require("user.harpoon")
  require("user.search-and-replace")
end
