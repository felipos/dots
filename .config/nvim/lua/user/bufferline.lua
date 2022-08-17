local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  print("bufferline plugin was not found")
  return
end

bufferline.setup{
  options = {
    modified_icon = "m",
  },
  -- see :h bufferline-highlights
  highlights = {
    fill = {
      bg = "",
    },
}}
