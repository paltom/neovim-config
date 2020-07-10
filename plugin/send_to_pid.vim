let s:loaded_guard = "g:loaded_send_to_pid"
if exists(s:loaded_guard)
  finish
endif

let s:last_send_to_pid = 0

function! s:term_job_pids(arglead, cmdline, curpos)

endfunction

function! s:set_pid(pid)
  if !empty(a:pid)
    let s:last_send_to_pid = str2nr(a:pid)
    let buf_send_to_pid = s:last_send_to_pid
  else
    let buf_send_to_pid = getbufvar("%", "send_to_pid", s:last_send_to_pid)
  endif
  if buf_send_to_pid == 0
    echohl ErrorMsg
    echomsg "Process to send lines to is not set. Use :SendToTerm <pid> to select process."
    echohl None
    return buf_send_to_pid
  endif
  call setbufvar("%", "send_to_pid", buf_send_to_pid)
  return buf_send_to_pid
endfunction

function! s:get_lines(first, last)
  return add(getline(a:first, a:last), "")
endfunction

function! s:pid2chan(pid)
echo func#pipe(nvim_list_chans(), [{chs -> filter(chs, {_, c -> has_key(c, "buffer") && nvim_buf_is_loaded(c['buffer'])})}])
endfunction

function! s:send_to_pid(...) range
  let pid = s:set_pid(a:1)
  let lines = s:get_lines(a:firstline, a:lastline)
  let channr = s:pid2chan(pid)
  call chansend(channr, lines)
endfunction

command! -nargs=? -complete=custom,s:term_job_pids -range SendToPID <line1>,<line2>call s:send_to_pid(<q-args>)

" let {s:loaded_guard} = v:true
