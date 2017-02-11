"------------------------------------------------------------------------------
function! Toggle_Status_Bar()
  if &laststatus == 0
    let &laststatus = 2
  else
    let &laststatus = 0
  endif
endfunction


"------------------------------------------------------------------------------
function! Toggle_Tabbar()
  if &showtabline == 0
    let &showtabline = 2
  else
    let &showtabline = 0
  endif
endfunction


"------------------------------------------------------------------------------
function! Toggle_Fold_Column()
  if &foldcolumn ># 0
    let g:toggle_fold_column_last = &foldcolumn
    let &foldcolumn = 0
  else
    if !exists('g:toggle_fold_column_last')
      let g:toggle_fold_column_last = 2
    endif
    let &foldcolumn = g:toggle_fold_column_last
  endif
endfunction


"------------------------------------------------------------------------------
if exists("&signcolumn")
  function! Toggle_SignColumn()
    if &signcolumn == 'yes'
      let &signcolumn='no'
    else
      let &signcolumn='yes'
    endif
  endfunction
endif


"------------------------------------------------------------------------------
function! Toggle_Maximize_Editing_Area()
  if !exists('g:maximize_editing_area')
    let g:maximize_editing_area = 0
  endif

  if g:maximize_editing_area == 0
    " deactivate all and remember old states
    if has("gui_running")
      let g:maximize_editing_area#guiopts = &go
      set go-=m
    endif
    let g:maximize_editing_area#numbers = &nu
    set nonu
    let g:maximize_editing_area#tabline = &showtabline
    set showtabline=0
    let g:maximize_editing_area#laststatus = &laststatus
    set laststatus=0
    let g:maximize_editing_area#foldcol = &foldcolumn
    set foldcolumn=0
    if exists("&signcolumn")
      let g:maximize_editing_area#signcolumn = &signcolumn
      set signcolumn=no
    endif
    let g:maximize_editing_area = 1
  else
    " reactivate
    if has("gui_running")
      let &go = g:maximize_editing_area#guiopts
    endif
    if exists("&signcolumn")
      let &signcolumn = g:maximize_editing_area#signcolumn
    endif
    let &nu = g:maximize_editing_area#numbers
    let &showtabline = g:maximize_editing_area#tabline
    let &laststatus = g:maximize_editing_area#laststatus
    let &foldcolumn = g:maximize_editing_area#foldcol
    let g:maximize_editing_area = 0
  endif
endfunction


"------------------------------------------------------------------------------
" commands
"------------------------------------------------------------------------------
command! MenuToggle             if &go=~'m'|set go-=m|else|set go+=m|endif
command! FoldColumnToggle       :call Toggle_Fold_Column()
command! StatusBarToggle        :call Toggle_Status_Bar()
command! TabbarToggle           :call Toggle_Tabbar()
command! MaximizeEditAreaToggle :call Toggle_Maximize_Editing_Area()

if exists("&signcolumn")
  command! SignColumnToggle :call Toggle_SignColumn()
else
  command! SignColumnToggle :echo 'The "signcolumn" option is not supported by this version.'
endif

" vim: tw=80:ts=2:sts=2:et
