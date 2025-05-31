let s:save_cpo = &cpo
set cpo&vim

" set to 1 if buffer is location list
let b:is_loclist = get(get(getwininfo(win_getid()), 0, {}), 'loclist', 0)

setlocal norelativenumber
setlocal number
set nobuflisted

let &cpo = s:save_cpo
