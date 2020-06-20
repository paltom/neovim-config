" Shell {{{
" `bash` directory must be in $PATH
set shell=bash
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

set termguicolors
let g:one_allow_italics = v:true
augroup colorscheme_fixes
  autocmd!
  autocmd ColorScheme * call colors#update_colors()
augroup end
colorscheme one
set background=light
let &fillchars = "vert: "

set nowrap
let &listchars = "tab:\u00bb ,trail:\u2423"
set list
set scrolloff=3
set sidescrolloff=10
let &listchars ..= ",precedes:\u27ea,extends:\u27eb"

augroup colorcolumn_automation
  autocmd!
  autocmd BufNewFile,BufRead,BufWinEnter,WinEnter * let &l:colorcolumn = "80,"..join(range(120, 999), ",")
  autocmd WinLeave * let &l:colorcolumn = join(range(1, 999), ",")
augroup end
augroup cursorline_automation
  autocmd!
  autocmd BufNewFile,BufRead,BufWinEnter,WinEnter * if &diff | setlocal nocursorline | else | setlocal cursorline | endif
  autocmd OptionSet diff if v:option_new | setlocal nocursorline | else | setlocal cursorline | endif
  autocmd WinLeave * setlocal nocursorline
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
