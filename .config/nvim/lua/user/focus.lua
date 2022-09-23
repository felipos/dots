local status_ok, focus = pcall(require, "focus")

if not status_ok then
	print("focus plugin was not found")
	return
end

focus.setup({
	autoresize = true,
	winhighlight = true,
})
