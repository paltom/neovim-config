let s:search_commands = {
      \ "forward": ["next", "first"],
      \ "backward": ["previous", "last"]
      \}
function! s:try_jump(list_prefix, commands)
  try
    execute a:list_prefix..a:commands[0]
  catch /E553:/
    execute a:list_prefix..a:commands[1]
  endtry
endfunction
function! search#jump(direction)
  let commands = get(s:search_commands, a:direction, s:search_commands["forward"])
  if len(getloclist(0)) > 0
    call s:try_jump("l", commands)
  elseif len(getqflist()) > 0
    call s:try_jump("c", commands)
  else
    let search_key = "n"
    if direction ==# "forward"
      let search_key = "n"
    elseif direction ==# "backward"
      let search_key = "N"
    endif
    execute "normal! "..search_key
  endif
endfunction
