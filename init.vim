let mapleader = " "
let maplocalleader = " "

" Shell {{{
" `bash` directory must be in $PATH
" set shell=bash.exe
" set shellcmdflag=-c
" let &shellpipe = '2>&1 | tee'
" set shellxquote=
" set shellslash
tnoremap <c-w> <c-\><c-n>
augroup terminal
  autocmd!
  autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no
  autocmd TermOpen,BufEnter,WinEnter term://* let b:siso = &sidescrolloff | set sidescrolloff=0
  autocmd BufLeave,WinLeave term://* let &sidescrolloff = b:siso
  autocmd TermOpen,WinEnter term://* startinsert
  autocmd TermLeave,BufLeave,WinLeave term://* stopinsert
augroup end
" }}}

" Providers {{{
" python {{{
set pyxversion=3
let g:loaded_python_provider = v:false
let g:python3_host_prog = expand(
      \ fnamemodify(expand("$MYVIMRC"), ":h")..
      \ "/pyenv/python3/Scripts/python.exe")
function! s:term_activate_venv()
  if exists("$VIRTUAL_ENV")
    let venv_path = fnamemodify(expand("$VIRTUAL_ENV"), ":p")
    let cmd = join(split(bufname(), ":")[2:-1], ":")
    if has("win32")
      let activation_script = expand(venv_path.."/Scripts/activate")
      if cmd =~# '\vsh(\.|$)'
        let activation_cmd = "\<c-e>\<c-u>source "..substitute(activation_script, '\', '/', "g")
      elseif cmd
        let activation_cmd = activation_script..".bat"
      endif
    endif
    if exists("activation_cmd")
      call chansend(getbufvar("%", "terminal_job_id"), activation_cmd.."\<cr>")
    endif
  endif
endfunction
augroup venv_activation
  autocmd!
  autocmd TermOpen *[^{FZF$}] call s:term_activate_venv()
augroup end
" }}}
" }}}

" Movements {{{
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l
inoremap <a-h> <c-\><c-n><c-w>h
inoremap <a-j> <c-\><c-n><c-w>j
inoremap <a-k> <c-\><c-n><c-w>k
inoremap <a-l> <c-\><c-n><c-w>l
vnoremap <a-h> <c-w>h
vnoremap <a-j> <c-w>j
vnoremap <a-k> <c-w>k
vnoremap <a-l> <c-w>l
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l

if has("nvim-0.4.2")
  set wildcharm=<tab>
  cnoremap <expr> <left>  wildmenumode() ? "\<up>"    : "\<left>"
  cnoremap <expr> <right> wildmenumode() ? "\<down>"  : "\<right>"
  cnoremap <expr> <up>    wildmenumode() ? "\<left>"  : "\<up>"
  cnoremap <expr> <down>  wildmenumode() ? "\<right>" : "\<down>"
  cnoremap <expr> <c-h>   wildmenumode() ? "\<up>"    : "\<c-h>"
  cnoremap <expr> <c-l>   wildmenumode() ? "\<down>"  : "\<c-l>"
  cnoremap <expr> <c-k>   wildmenumode() ? "\<left>"  : "\<c-k>"
  cnoremap <expr> <c-j>   wildmenumode() ? "\<right>" : "\<c-j>"
endif
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

" XXX: fzf binary need to be installed manually on Windows
let g:fzf_layout = {"window": "botright 12 split enew"}
let g:fzf_action = {
      \ "ctrl-t": "tab split",
      \ "ctrl-s": "split",
      \ "ctrl-v": "vsplit",
      \}

" easier jumping through searches
nnoremap <silent> ]s :<c-u>call search#jump("forward")<cr>
nnoremap <silent> [s :<c-u>call search#jump("backward")<cr>
" }}}

" Misc {{{
set hidden

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

augroup colorscheme_fixes
  autocmd!
  autocmd ColorScheme * call colors#update_colors()
augroup end
let g:one_allow_italics = v:true
let g:neosolarized_italic = v:true
let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
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
  let stl ..= "%( (%{pathshorten(func#call_if_exists_or('FugitiveHead', [8], ''))})%)"
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

function! s:tabpage_label(tabpagenr)
  if a:tabpagenr == tabpagenr()
    let label = "%#TablineSel#"
  else
    let label = "%#Tabline#"
  endif
  let label ..= "%"..a:tabpagenr."T "
  let label ..= "%{tabline#modified("..a:tabpagenr..")} "
  let label ..= "%{tabline#filename("..a:tabpagenr..")} "
  let label ..= a:tabpagenr.."|"
  return label
endfunction
function! Tabline()
  let tbl = ""
  for tabpagenr in range(1, tabpagenr("$"))
    let tbl ..= s:tabpage_label(tabpagenr)
  endfor
  let tbl ..= "%#TablineFill#"
  let tbl ..= "%="
  return tbl
endfunction
set tabline=%!Tabline()
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
"packadd nvim-lsp
"lua require'nvim_lsp'.eclipse_jdt_ls.setup{}
"augroup lsp_omnifunc
"  autocmd!
"  autocmd Filetype java setlocal omnifunc=v:lua.vim.lsp.omnifunc
"augroup end
" Using coc.nvim
" XXX: Need to be installed manually
let g:coc_global_extensions = [
      \ "coc-json",
      \ "coc-java",
      \ "coc-vimlsp",
      \ "coc-xml",
      \ "coc-tsserver",
      \ "coc-html",
      \ "coc-css",
      \ "coc-python",
      \]
inoremap <silent><expr> <c-space> coc#refresh()
let g:coc_snippet_next = "<tab>"
let g:coc_snippet_prev = "<s-tab>"
inoremap <silent><expr> <tab>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<c-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', ''])\<cr>" :
      \ "\<tab>"
nmap <silent> [d <plug>(coc-diagnostic-prev)
nmap <silent> ]d <plug>(coc-diagnostic-next)
nmap <silent> <leader>gd <plug>(coc-definition)
nmap <silent> <leader>gt <plug>(coc-type-definition)
nmap <silent> <leader>gi <plug>(coc-implementation)
nmap <silent> <leader>gr <plug>(coc-references)
function! s:show_documentation()
  if index(["vim", "help"], &filetype) >= 0
    execute "help "..expand("<cword>")
  else
    call CocAction("doHover")
  endif
endfunction
nnoremap <silent> K <cmd>call <sid>show_documentation()<cr>
xmap <silent><leader>f <plug>(coc-format-selected)
nmap <silent><leader>f <plug>(coc-format-selected)
xmap <leader>a <plug>(coc-codeaction-selected)
nmap <leader>a <plug>(coc-codeaction-selected)
nmap <leader>A <plug>(coc-codeaction)
nmap <leader>oi <cmd>CocCommand editor.action.organizeImport<cr>

xmap if <plug>(coc-funcobj-i)
omap if <plug>(coc-funcobj-i)
xmap af <plug>(coc-funcobj-a)
omap af <plug>(coc-funcobj-a)
xmap ic <plug>(coc-classobj-i)
omap ic <plug>(coc-classobj-i)
xmap ac <plug>(coc-classobj-a)
omap ac <plug>(coc-classobj-a)

command! -nargs=0 CocFormat call CocAction("format")
function! s:coc_fold_completions(...)
  return join(["comment", "imports", "region"], "\n")
endfunction
command! -nargs=? -complete=custom,<sid>coc_fold_completions CocFold call CocAction('fold', <f-args>)
augroup coc_disabled
  autocmd!
  autocmd TermOpen * let b:coc_enabled = 0
augroup end
" }}}

" Explorer {{{
nnoremap <leader>E <cmd>NERDTreeToggleVCS<cr>
let g:NERDTreeWinSize = 40
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeQuitOnOpen = 1
" }}}

" Git {{{
nnoremap <silent> <leader>hd <cmd>SignifyHunkDiff<cr>
nnoremap <silent> <leader>hu <cmd>SignifyHunkUndo<cr>
" }}}

" vim:foldmethod=marker
