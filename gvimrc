" Font
"set guifont=Monaco:h12.00
set guifont=Menlo:h12.00

" No audible bell
set vb

" No toolbar
set guioptions-=T

" No scrollbars
set guioptions-=rL

" Use console dialogs
set guioptions+=c

set lines=50 columns=200

set transparency=15

" Local config
if filereadable(".gvimrc.local")
  source .gvimrc.local
endif

if has("gui_macvim")
  macmenu &File.New\ Tab key=<nop>
  map <D-t> <Plug>PeepOpen
end

" Toggle text wrapping
function! ToggleWrap()
  if (&wrap == 1)
    if (&linebreak == 0)
      set linebreak
    else
      set nowrap
    endif
  else
    set wrap
    set nolinebreak
  endif
endfunction

nnoremap <D-w> :call ToggleWrap()<CR>
