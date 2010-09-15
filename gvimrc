" Font
set guifont=Monaco:h12.00

" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

set lines=50 columns=200

set transparency=12

" Local config
if filereadable(".gvimrc.local")
  source .gvimrc.local
endif

" if has("gui_macvim")
"   "macmenu &File.New\ Tab key=<nop>
"   map <Leader>t <Plug>PeepOpen
" end
