function! colors#update_colors()
  highlight! link SignColumn LineNr
  highlight! link Folded FoldColumn
  highlight! link VertSplit StatusLineNC
  execute "highlight! stl_venv guifg=#719e07 gui=reverse guibg=White"
  execute "highlight! stl_cwd guifg=#719e07 gui=bold,reverse guibg=Black"
  execute "highlight! stl_git guifg=#b58900"
  execute "highlight! stl_filename guifg=#268bd2"
  execute "highlight! stl_lsp_ok guifg=#719e07 gui=bold "
  execute "highlight! stl_lsp_err guifg=#dc322f gui=bold"
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
  let all_colors = filter(all_colors, {_, c -> c =~# '\v^#\x{6}'})
  let all_colors = sort(all_colors)
  return all_colors
endfunction

