function! statusline#cwd()
  return pathshorten(fnamemodify(getcwd(), ":p")[:-2])
endfunction

function! s:relative_path(path, basepath)
  let full_basepath = fnamemodify(a:basepath, ":p")
  let relative_path = matchstr(a:path, '\v'..full_basepath..'\zs.*$')
  if empty(relative_path)
    return a:path
  else
    return relative_path
  endif
endfunction

let s:git_type_to_name = {
      \ "0": "index",
      \ "2": "current",
      \ "3": "incoming",
      \}
function! statusline#filename()
  let bufname = bufname()
  let filename = fnamemodify(bufname, ":t")
  " Handle special cases
  " filetype-based
  if index(["help"], &filetype) >= 0
    return filename
  endif
  const full_bufname = fnamemodify(bufname, ":p")
  " git diff buffers
  if full_bufname =~# '\v^fugitive:'..expand("/")..'{2,}'
    let git_buf_type = matchstr(full_bufname,
          \ '\v'..escape('.git'..expand("/") , '\.')..'{2}\zs\x+\ze')
    if !empty(git_buf_type)
      let git_type_name = get(s:git_type_to_name, git_buf_type, "("..git_buf_type[:7]..")")
      return filename.." @ "..git_type_name
    endif
  endif
  " terminal buffers
  if full_bufname =~# '\v^term://'
    let splitted_term_uri = split(full_bufname, ":")
    let shell_pid = fnamemodify(splitted_term_uri[1], ":t")
    let shell_exec = fnamemodify(splitted_term_uri[-1], ":t")
    return join([splitted_term_uri[0], shell_pid, shell_exec], ":")
  endif
  " XXX: add more special cases here
  " Handle buffer not associated with file
  if empty(filename)
    return "[No Name]"
  endif
  " Basic case
  let relative_dir = func#pipe(full_bufname, [
        \ function("s:relative_path", [getcwd()]),
        \ function("fnamemodify", [":h"]),
        \])
  if relative_dir ==# "."
    return filename
  else
    return expand(join([pathshorten(relative_dir), filename] , "/"))
  endif
endfunction

function! statusline#lsp()
  let filetype = getbufvar(bufname(), "&filetype")
  let servers = func#call_if_exists_or('lsp#get_whitelisted_servers', [filetype], [])
  if empty(servers)
    return 2
  endif
  let statuses = servers->map({_, name -> func#call_if_exists_or('lsp#get_server_status', [name], '')})
  for status in statuses
    if status !=# 'running'
      return 1
    endif
  endfor
  return 0
endfunction
