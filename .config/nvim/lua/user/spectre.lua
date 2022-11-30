local status_ok, spectre = pcall(require, "spectre")

if not status_ok then
  print("could not require spectre plugin. is the it installed?")
  return
end
