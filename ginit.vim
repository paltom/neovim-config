if exists("g:GuiLoaded")
  call GuiClipboard()
  GuiTabline 0
  GuiPopupmenu 0
  GuiFont! Hack:h12
  call GuiWindowMaximized(v:true)
endif
set guicursor=n-v-c-sm:block-Cursor
set guicursor+=i-ci-ve:ver25-blinkwait200-blinkon500-blinkoff500
set guicursor+=r-cr-o:hor20

set clipboard+=unnamed
inoremap <expr> <c-v> edit#insert_mode_put()
inoremap <c-g><c-v> <c-v>

if !v:vim_did_enter && empty(func#call_if_exists_or('xolox#session#find_current_session', [], ''))
  execute "cd ~"
endif
