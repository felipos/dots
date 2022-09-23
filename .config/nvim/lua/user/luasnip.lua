local status_ok, _ = pcall(require, "luasnip")
if not status_ok then
	print("luasnip plugin was not found")
	return
end

require("luasnip.loaders.from_vscode").load({ include = { "javascript" } })
require("luasnip.loaders.from_vscode").load({ include = { "latex" } })
require("luasnip.loaders.from_vscode").load({ include = { "css" } })
require("luasnip.loaders.from_vscode").load({ include = { "html" } })
require("luasnip.loaders.from_vscode").load({ include = { "lua" } })
require("luasnip.loaders.from_vscode").load({ include = { "markdown" } })
require("luasnip.loaders.from_vscode").load({ include = { "sql" } })
require("luasnip.loaders.from_vscode").load({ include = { "c" } })
