local status_ok, search_and_replace = pcall(require, "nvim-search-and-replace")
if not status_ok then
	print("search-and-replace plugin was not found")
	return
end

search_and_replace.setup({
  ignore = {'**/node_modules/**', '**/.git/**',  '**/.gitignore', '**/.gitmodules','build/**', '**/dist/**'},

  -- save the changes after replace
  update_changes = false,

  -- keymap for search and replace
  replace_keymap = '<leader>gr',

  -- keymap for search and replace ( this does not care about ignored files )
  replace_all_keymap = '<leader>gR',

  -- keymap for search and replace
  replace_and_save_keymap = '<leader>r',

  -- keymap for search and replace ( this does not care about ignored files )
  replace_all_and_save_keymap = '<leader>gU',
})
