" Shell {{{
" `bash` directory must be in $PATH
set shell=bash.exe
set shellcmdflag=-c
set shellquote=\"
set shellslash

tnoremap <c-w> <c-\><c-n><c-w>
" }}}

" Searching {{{
set ignorecase
set smartcase
augroup highlight_while_searching_only
  autocmd!
  set nohlsearch
  autocmd CmdlineEnter /,\? set hlsearch
  autocmd CmdlineLeave /,\? set nohlsearch
augroup end
vnoremap / y/<c-r>"<cr>
vnoremap g/ /
" }}}

" Misc {{{
let g:sneak#label = v:true

let g:pear_tree_ft_disabled = [
      \ "vim",
      \]
let g:pear_tree_repeatable_expand = v:false
let g:pear_tree_smart_openers = v:true
let g:pear_tree_smart_closers = v:true
let g:pear_tree_smart_backspace = v:true

inoremap <c-j> <c-n>
inoremap <c-k> <c-p>
noremap H ^
noremap L $
nnoremap <backspace> <c-^>

set updatetime=100
" }}}

" Formatting {{{
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set smartindent

nnoremap <silent> [<space> :<c-u>call formatting#empty_lines(v:count1, v:true)<cr>
nnoremap <silent> ]<space> :<c-u>call formatting#empty_lines(v:count1, v:false)<cr>

let g:autoretab = v:true
augroup auto_tab_replacement
  autocmd!
  autocmd BufWrite * if g:autoretab | retab | endif
augroup end
let g:autoremove_trail_space = v:true
augroup auto_remove_trail_space
  autocmd!
  autocmd BufWrite * call formatting#remove_trail_space()
augroup end
"}}}

" Theme {{{
set number
set relativenumber
set numberwidth=5
set signcolumn=yes
let g:signify_sign_change = '~'

let g:one_allow_italics = v:true
augroup colorscheme_fixes
  autocmd!
  autocmd ColorScheme * call colors#update_colors()
augroup end
colorscheme NeoSolarized
set background=dark
let &fillchars = "vert: "

set nowrap
let &listchars = "tab:\u00bb "
let &listchars ..= ",trail:\u00b7"
let &listchars ..= ",precedes:\u27ea"
let &listchars ..= ",extends:\u27eb"
set list
set scrolloff=3
set sidescrolloff=10

augroup colorcolumn_automation
  autocmd!
  autocmd BufNewFile,BufRead,BufWinEnter,WinEnter *
              \ let &l:colorcolumn = "80,"..join(range(120, 999), ",")
  autocmd WinLeave * let &l:colorcolumn = join(range(1, 999), ",")
augroup end
augroup cursorline_automation
  autocmd!
  autocmd BufNewFile,BufRead,BufWinEnter,WinEnter *
              \ if &diff | setlocal nocursorline | else | setlocal cursorline | endif
  autocmd OptionSet diff
              \ if v:option_new | setlocal nocursorline | else | setlocal cursorline | endif
  autocmd WinLeave * setlocal nocursorline
augroup end

let g:virtualenv_stl_format = '(%n)'
function! Statusline()
  let stl   = "%#stl_venv#"
  let stl ..= "%(%{func#call_if_exists_or('virtualenv#statusline', [], '')} %)"
  let stl ..= "%#stl_cwd#"
  let stl ..= "%{statusline#cwd()} "
  let stl ..= "%#stl_git#"
  let stl ..= "%( (%{func#call_if_exists_or('FugitiveHead', [8], '')})%)"
  let stl ..= "%(%{func#call_if_exists_or('sy#repo#get_stats_decorated', [], '')}%)"
  let stl ..= "%#stl_filename#"
  let stl ..= " %{statusline#filename()} %m%r"
  let stl ..= "%*"
  let stl ..= "%="
  let stl ..= "%($[%{func#call_if_exists_or('xolox#session#find_current_session', [], '')}] %)"
  let stl ..= "%(%#stl_lsp_ok#%{statusline#lsp()==0?'o':''}%#stl_lsp_err#%{statusline#lsp()==1?'x':''}%* %)"
  let stl ..= "\u2261%p%%"
  return stl
endfunction
function! StatuslineNC()
  let stl   = "%{statusline#cwd()}"
  let stl ..= " "
  let stl ..= "%{statusline#filename()} %m%r"
  let stl ..= "%*"
  let stl ..= "%="
  return stl
endfunction
set statusline=%!Statusline()
augroup statusline
  autocmd!
  autocmd WinEnter,BufWinEnter * setlocal statusline=%!Statusline()
  autocmd WinLeave * setlocal statusline=%!StatuslineNC()
augroup end
" }}}

" Sessions {{{
set sessionoptions-=help
set sessionoptions+=resize
set sessionoptions+=winpos
let g:session_directory = expand(fnamemodify(expand("$MYVIMRC"), ":h").."/sessions")
let g:session_autoload = "yes"
let g:session_autosave = "yes"
let g:session_default_to_last = v:true
" }}}

" LSP {{{
" }}}

" vim:foldmethod=marker
