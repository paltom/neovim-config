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
function! colors#list_base()
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
