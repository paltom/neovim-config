setlocal tabstop=2 softtabstop=2 shiftwidth=2

if !exists("b:undo_ftplugin")
  let b:undo_ftplugin = ""
endif
let b:undo_ftplugin ..= "|setlocal tabstop< softtabstop< shiftwidth<"
