local status_ok, image_viwer = pcall(require, "image")
if not status_ok then
	print("image plugin was not found")
	return
end

image_viwer.setup({
	render = {
		min_padding = 5,
		show_label = true,
		use_dither = true,
	},
	events = {
		update_on_nvim_resize = true,
	},
})
