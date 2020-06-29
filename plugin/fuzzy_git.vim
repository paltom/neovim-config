let s:loaded_guard = "g:loaded_fuzzy_git"
if exists(s:loaded_guard)
  finish
endif

let s:git_cmd_template = "git --git-dir=%s --work-tree=%s %s"

function! s:execute_git(git_dir, command)
  let git_dir = a:git_dir
  if fnamemodify(git_dir, ":t") =~# '\v\.git$'
    let git_dir = fnamemodify(git_dir, ":h")
  endif
  if empty(git_dir)
    return []
  endif
  let git_command = printf(s:git_cmd_template,
        \ expand(git_dir.."/.git"),
        \ git_dir,
        \ a:command,
        \)
  return func#pipe(systemlist(git_command), [
        \ function("map", [{_, line -> trim(line)}]),
        \])
endfunction

if      exists("*fzf#run") &&
      \ exists("*fzf#wrap") &&
      \ exists(":Git") == 2
  function! GitBranches()
    let dict = {
          \ "source": func#pipe(
          \   <sid>execute_git(
          \     func#call_if_exists_or('FugitiveGitDir', [], ''),
          \     "branch -a"), [
          \   function("filter", [{_, branch -> !empty(branch)}]),
          \   function("filter", [{_, branch -> branch !~# '\v^\s*remotes/.{-}/HEAD\s+-\>\s+'}]),
          \ ]),
          \}
    function! dict.sink(lines)
      if a:lines !~# '\v^\s*\*'
        let branch = matchstr(a:lines, '\v^(\s*remotes/.{-}/)?\zs.*\ze$')
        execute "Git checkout "..branch
      endif
    endfunction
    call fzf#run(fzf#wrap(dict))
  endfunction

  command! GitBranches call GitBranches()
endif

let {s:loaded_guard} = v:true
