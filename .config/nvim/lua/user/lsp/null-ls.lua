local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	print("null-ls is not installed")
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics -- diagnostics is actually the linter

null_ls.setup({
	debug = false,
	sources = {
		formatting.stylua,
		diagnostics.luacheck.with({ extra_args = { "--globals vim" } }),
		formatting.prettier.with({ extra_args = {} }),
		diagnostics.eslint,
	},
})
