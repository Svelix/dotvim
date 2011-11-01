syn match TAB_CHAR "\t"
hi link TAB_CHAR rubySpaceError

if exists("ruby_space_errors")
  if !exists("ruby_no_trail_space_error")
    syn match rubySpaceError display excludenl "\s\+$"
  endif
  if !exists("ruby_no_tab_space_error")
    syn match rubySpaceError display " \+\t"me=e-1
  endif
endif

