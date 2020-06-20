function! colors#update_colors()
  highlight! link SignColumn LineNr
  highlight! link Folded FoldColumn
  highlight! link VertSplit StatusLineNC
  let stl_fg = synIDattr(synIDtrans(highlightID("StatusLine")), "fg", "gui")
  execute "highlight! stl_venv guifg=#719e07 gui=reverse guibg=Black"
  execute "highlight! stl_cwd guifg=#719e07 gui=bold,reverse guibg=White"
  execute "highlight! stl_git guifg=#b58900"
  execute "highlight! stl_filename guifg="..stl_fg
  execute "highlight! stl_lsp_ok guifg=#719e07 gui=bold "
  execute "highlight! stl_lsp_err guifg=#dc322f gui=bold"
  let signcolumn_bg = synIDattr(synIDtrans(highlightID("SignColumn")), "bg", "gui")
  let signcolumn_add = synIDattr(synIDtrans(highlightID("DiffAdd")), "fg", "gui")
  let signcolumn_change = synIDattr(synIDtrans(highlightID("DiffChange")), "fg", "gui")
  let signcolumn_delete = synIDattr(synIDtrans(highlightID("DiffDelete")), "fg", "gui")
  execute "highlight! SignifySignAdd guifg="..signcolumn_add.." guibg="..signcolumn_bg
  execute "highlight! SignifySignChange guifg="..signcolumn_change.." guibg="..signcolumn_bg
  execute "highlight! SignifySignDelete guifg="..signcolumn_delete.." guibg="..signcolumn_bg
  execute "highlight! SignifySignChangeDelete guifg="..signcolumn_delete.." guibg="..signcolumn_bg
  execute "highlight! link vimSetEqual NONE"
  execute "highlight! link vimSet NONE"
endfunction

let s:highlight_default_groups = [
      \ "ColorColumn", "Conceal", "Cursor", "CursorIM", "CursorColumn",
      \ "CursorLine", "Directory", "DiffAdd", "DiffChange", "DiffDelete",
      \ "DiffText", "EndOfBuffer", "TermCursor", "TermCursorNC", "ErrorMsg",
      \ "VertSplit", "Folded", "FoldColumn", "SignColumn", "Substitute",
      \ "LineNr", "CursorLineNr", "MatchParen", "ModeMsg", "MsgArea",
      \ "MsgSeparator", "MoreMsg", "NonText", "Normal", "NormalFloat",
      \ "NormalNC", "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
      \ "Question", "QuickFixLine", "Search", "SpecialKey", "SpellBad",
      \ "SpellCap", "SpellLocal", "SpellRare", "StatusLine", "StatusLineNC",
      \ "TabLine", "TabLineFill", "TabLineSel", "Title", "Visual",
      \ "VisualNOS", "WarningMsg", "Whitespace", "WildMenu",
      \]
function! s:base_colors()
  let all_colors = []
  for hlgroup in s:highlight_default_groups
    for attr in ["fg", "bg"]
      let color = synIDattr(synIDtrans(highlightID(hlgroup)), attr, "gui")
      if index(all_colors, color) < 0
        let all_colors = add(all_colors, color)
      endif
    endfor
  endfor
  let all_colors = func#pipe(all_colors,[
        \ function("filter", [{_, c -> c =~# '\v^#\x{6}'}]),
        \ function("sort", []),
        \])
  return all_colors
endfunction

