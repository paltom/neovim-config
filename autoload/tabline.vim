function! tabline#modified(tabpagenr)
  for winnr in range(1, tabpagewinnr(a:tabpagenr, "$"))
    if gettabwinvar(a:tabpagenr, winnr, "&modified")
      return "+"
    endif
  endfor
  return ""
endfunction

function! tabline#filename(tabpagenr)
  const winnr = tabpagewinnr(a:tabpagenr)
  const bufnr = tabpagebuflist(a:tabpagenr)[winnr - 1]
  const bufname = bufname(bufnr)
  const filename = fnamemodify(bufname, ":t")
  const full_bufname = fnamemodify(bufname, ":p")
  " Handle special cases
  " terminal buffers
  if full_bufname =~# '\v^term://'
    const splitted_term_uri = split(full_bufname, ":")
    const shell_pid = fnamemodify(splitted_term_uri[1], ":t")
    const shell_exec = fnamemodify(splitted_term_uri[-1], ":t")
    return join([splitted_term_uri[0], shell_pid, shell_exec], ":")
  endif
  " XXX: add more special cases here
  " Handle buffer not associated with file
  if empty(filename)
    return "[No Name]"
  endif
  " Basic case
  return filename
endfunction
