" *****************************************************************************
" Pathogen ********************************************************************
" *****************************************************************************
silent! call pathogen#runtime_append_all_bundles()


" *****************************************************************************
" Settings ********************************************************************
" *****************************************************************************

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Don't warn before switching away from an unsaved buffer
set hidden

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50         " keep 50 lines of command line history
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands
set incsearch          " do incremental searching

"set foldmethod=syntax
autocmd FileType css setlocal foldmethod=indent shiftwidth=2 tabstop=2
autocmd FileType sass setlocal foldmethod=indent shiftwidth=2 tabstop=2
autocmd FileType scss setlocal foldmethod=indent shiftwidth=2 tabstop=2

" Don't use Ex mode, instead use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

set cursorline " highlight the cursor line
set hlsearch
:nnoremap <ESC><ESC> :nohlsearch<cr>
"nnoremap <esc> :noh<return><esc>
" map <Leader>h :set invhls <CR>    " Hide search highlighting
nnoremap <Leader>h :set syntax=haml <CR>


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufNewFile,BufRead *.xml source ~/.vim/ftplugin/xml.vim

  augroup END
  
  autocmd WinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Always display the status line
set laststatus=2

" Fancy status line; even displays the time
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-13(\ %l,%c-%v\ %)%-21{strftime('%a\ %y.%m.%d\ %H:%M\')}%P
set statusline+=%{rvm#statusline()}

" \ is the leader character
let mapleader = "\\"

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
map <Leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Maps autocomplete to tab
" imap <Tab> <C-N>
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" For Haml
au! BufRead,BufNewFile *.haml         setfiletype haml

" Press ^F from insert mode to insert the current file name
imap <C-F> <C-R>=expand("%")<CR>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Edit routes
command! Rroutes :e config/routes.rb
command! RTroutes :tabe config/routes.rb

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Color scheme
colorscheme vividchalk
"colorscheme molokai
"let g:molokai_original = 1
"colorscheme mustang
"colorscheme clouds_midnight
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" (only complete to the longest unambiguous match, and show a menu)
set completeopt=longest,menu
set wildmode=list:longest,list:full
set complete=.,t

" case only matters with mixed case expressions
set ignorecase
set smartcase

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" bind \d to toggle file browser
" requires NERDTree
nmap <D-d> :NERDTreeToggle<CR>

" bind command-/ to toggle comment
" requires NERD Commenter to be installed
nmap <D-/> <Leader>c<space>
vmap <D-/> <Leader>c<space>
imap <D-/> <C-O><Leader>c<space>

" change MakeGreen from <Leader>t to <Leader>]
map <Leader>] <Plug>MakeGreen 

map <D-1> :tabn 1<CR>
map <D-2> :tabn 2<CR>
map <D-3> :tabn 3<CR>
map <D-4> :tabn 4<CR>
map <D-5> :tabn 5<CR>
map <D-6> :tabn 6<CR>
map <D-7> :tabn 7<CR>
map <D-8> :tabn 8<CR>
map <D-9> :tabn 9<CR>

nmap <D-]> >>
vmap <D-]> >>
imap <D-]> <C-O>>>

nmap <D-[> <<
vmap <D-[> <<
imap <D-[> <C-O><<

imap <C-l> <Space>=><Space>

nmap <leader>v :vsplit<CR> <C-w><C-w>
nmap <leader>s :split<CR> <C-w><C-w>

nmap <leader>w <C-w><C-w>_




inoremap <D-CR> <C-O>o

" \F to startup an ack search
map <leader>F :Ack<space>

function! RedoMigration(args)
  let ver = matchstr(getreg("%"),'\<db/migrate/0*\zs\d*\ze_')
  execute ":! rake db:migrate:redo VERSION=".ver
endfunction

map !m :call RedoMigration("")

function! RunSpec(args)
  execute ":wa"
  if exists("b:rails_root") && filereadable(b:rails_root . "/script/spec")
    let spec = b:rails_root . "/script/spec"
  else
    let spec = "bundle exec rspec"
  end
  let cmd = ":! " . spec . " % -cfn " . a:args
  execute cmd
endfunction

map ,S :call RunSpec("-l " . <C-r>=line('.')<CR>)<CR>
map ,s :call RunSpec("")<CR>

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo
    exec ":!script/test " . a:filename
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_spec_file = match(expand("%"), '_spec.rb$') != -1
    if in_spec_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>t :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>T :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>


" ******************************************************************************
" Green Herb *******************************************************************
" ******************************************************************************

function! GreenHerbIngredientList()
  execute ":%s:\\v^((\\u|\\s|\\d|\\%)+(\\u|\\d|\\%))\\s*-\\s*(.*)$:  <dt>\\1</dt>\r  <dd>\\4</dd>:g"
endfunction

function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ ygv"=TwiddleCase(@")<CR>Pgv

" map <Leader>r <Plug>MakeGreen
map <Leader>r :!ruby %

if has("gui_running")
  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen
endif


autocmd BufNewFile,BufRead *_spec.rb compiler rspec

map <buffer> <silent> <Leader>td <Plug>ToggleDone
map <buffer> <silent> <Leader>tc <Plug>ShowContext
map <buffer> <silent> <Leader>ta <Plug>ShowAll
map <buffer> <silent> <Leader>tp <Plug>FoldAllProjects

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

function! HandleURI()
  let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
  if s:uri != ""
    let s:uri = escape (s:uri, "#?&;|%")
    exec "!open \"" . s:uri . "\""
  else
    echo "No URI found in line."
  endif
endfunction
map <Leader>w :call HandleURI()<CR>

compiler rubyunit
nnoremap <Leader>fd :cf /tmp/autotest.txt<cr> :compiler rubyunit<cr>

function! RestartRailsApp()
  exec "!touch tmp/restart.txt"
endfunction
map <Leader>rr :call RestartRailsApp()<CR>



" *****************************************************************************
" Navigation ******************************************************************
" *****************************************************************************

" Dvorak-centric benefits
no s :
no S :
no - $
no _ ^
"function! DvorakOff()
  "nunmap h
  "nunmap t
"endfunction

" Don't need to hold shift to hit a colon in normal mode
nnoremap ; :

" Move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Zoom the current window
map <Leader><Leader> :ZoomWin<CR>

" Make j and k move through screen lines rather than actual file lines
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful
nnoremap j gj
nnoremap k gk

" Use space to center window in normal mode
nmap <space> zz

" Make search results move to center of screen
nmap n nzz
nmap N Nzz

" Because F1 is so dog-gone close to the esc key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Leader shortcuts for Rails commands
map <Leader>m :Rmodel
map <Leader>c :Rcontroller
map <Leader>v :Rview
map <Leader>u :Runittest
map <Leader>f :Rfunctionaltest
map <Leader>tm :RTmodel
map <Leader>tc :RTcontroller
map <Leader>tv :RTview
map <Leader>tu :RTunittest
map <Leader>tf :RTfunctionaltest
map <Leader>sm :RSmodel
map <Leader>sc :RScontroller
map <Leader>sv :RSview
map <Leader>su :RSunittest
map <Leader>sf :RSfunctionaltest


" *****************************************************************************
" Unknown stuff I found lying around ... what does it mean? *******************
" *****************************************************************************

nnoremap <leader><Space> :%s/\s\+$//<cr>:let @/=''<CR>
nnoremap <leader>v V`]

" Font
"set guifont=Monaco:h12.00
set guifont=Menlo:h12.00
"set guifont=Inconsolata-dz:h14.00

if has("gui_running")

  " No audible bell
  set vb

  " No toolbar
  set guioptions-=T

  " No scrollbars
  set guioptions-=rL

  " Don't use gui tabs
  set guioptions-=e

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
end
