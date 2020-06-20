function! func#call_if_exists_or(func_name, args, default_return_value)
  if !exists("*"..a:func_name)
    return a:default_return_value
  endif
  return call(a:func_name, a:args)
endfunction

function! func#pipe(value, funcs)
  let value = a:value
  for Func in a:funcs
    let value = call(get(Func, "name"), insert(get(Func, "args"), value))
  endfor
  return value
endfunction
