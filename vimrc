execute pathogen#infect()
syntax on

set shell=/bin/sh

set background=dark
" set background=light

colorscheme solarized

let mapleader=","

filetype plugin indent on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set noswapfile
set pastetoggle=<F2>

" map <Leader>rt :!ctags --tag-relative --extra=+f -Rf.git/tags --exclude=.git, pkg --languages=-javascript,-sql<CR><CR>
map <Leader>rt :!ctags -R .<CR><CR>
set tags=./tags

set ruler
set laststatus=2

set nocompatible
set autoindent
set showcmd
" set relativenumber
set suffixesadd=.rb
set path+=lib/**,spec**
let g:ruby_path = &path

let ruby_space_errors = 1
let c_space_errors = 1
set colorcolumn=81


" Control P
if exists("g:ctrlp_user_command")
  unlet g:ctrlp_user_command
endif
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command =
        \ 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$|bundle$"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif
let g:ctrlp_map = '<Leader>t'
nnoremap <silent> ,t :CtrlP<CR>
nnoremap <silent> ,b :CtrlPBuffer<cr>
let g:ctrlp_by_filename = 1
let g:ctrlp_switch_buffer = 0


" Ultra Snipps
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Sudo write
cmap w!! w !sudo tee % >/dev/null

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Resize windows with arrow keys
nnoremap <D-Up> <C-w>+
nnoremap <D-Down> <C-w>-
nnoremap <D-Left> <C-w><
nnoremap <D-Right>  <C-w>>

" The silver surfer
nmap ,ag :Ag ""<Left>
nmap ,af :AgFile ""<Left>

" NeoComplete startup
let g:neocomplete#enable_at_startup = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Lusty Explorer
set hidden

" Lusty Juggler
let g:LustyJugglerSuppressRubyWarning = 1
let g:LustyJugglerAltTabMode = 1
let g:LustyJugglerShowKeys = 'a' " show a/s/d/f keys

" Tidy
:vmap ,gt :!tidy -q -i --show-errors 0<CR>

" persistent undos - undo after you re-open the file
" but this gives warnings under command line vim
" use only in macvim
if v:version > '702'
  set undodir=~/.vim/backups
  set undofile
endif

" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap ,w :StripTrailingWhitespaces<CR>
