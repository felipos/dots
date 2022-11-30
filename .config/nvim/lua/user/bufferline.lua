local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  print("bufferline plugin was not found")
  return
end

bufferline.setup{
  options = {
    modified_icon = "m",
    max_name_length = 25,
    tab_size = 25,
  },
  -- see :h bufferline-highlights
  highlights = {
    fill = {
      bg = "",
    },
}}
