runtime pack/colorscheme/start/NeoSolarized/colors/NeoSolarized.vim

highlight! link SignColumn LineNr
highlight! link Folded FoldColumn
highlight! link VertSplit StatusLineNC
let stl_fg = synIDattr(synIDtrans(highlightID("StatusLine")), "fg", "gui")
execute "highlight! stl_venv guifg=#719e07 gui=reverse guibg=Black"
execute "highlight! stl_cwd guifg=#719e07 gui=bold,reverse guibg=White"
execute "highlight! stl_git guifg=#b58900"
execute "highlight! stl_filename guifg="..stl_fg
execute "highlight! stl_lsp_ok guifg=#719e07 gui=bold"
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

let g:colors_name = "MyNeoSolarized"
