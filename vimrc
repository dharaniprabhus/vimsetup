set langmenu=en_US
let $LANG = 'en_US'
syntax on
let mapleader = " "
set noerrorbells
set belloff=all
set encoding=utf-8
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set undodir=~/vimfiles/undo
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set modelines=0   " Disable modelines as a security precaution
set nomodeline
set rnu
set colorcolumn=80
set textwidth=80
set colorcolumn=+1
set numberwidth=5
set mmp=5000
set splitright
set splitbelow
set tags=./tags;/
call plug#begin('~/vimfiles/plugged')
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'chrisbra/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdcommenter'
  Plug 'burntsushi/ripgrep'
  Plug 'felikz/ctrlp-py-matcher'
call plug#end()

colorscheme gruvbox
let g:gruvbox_contrast_dark='soft'
 " PyMatcher for CtrlP
if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

if executable('rg')
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
    "let g:rg_derive_root='true'
endif
let g:ctrlp_working_path_mode = ''
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.exe$\|\.so$\|\.dat$\|\.patch$\|\.cmake$\|\.zip$\|\.png$\|\.in$\|\.out$'
  \ }
let g:ctrlp_max_files = 0
let ctrlp_lazy_update=350
let ctrlp_clear_cache_on_exit=0
let ctrlp_by_filename=1
let g:ctrlp_map = '<c-p>'
" https://sourceforge.net/projects/ctags/files/ctags/
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']

set guifont=consolas:h12
if has("unix")
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\( \)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ' '.l:gf_size_whole
      let &guifont = substitute(&guifont, ' \d\+$', l:new_font_size, '')
    endfunction
else
    function! FontSizePlus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole + 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction

    function! FontSizeMinus ()
      let l:gf_size_whole = matchstr(&guifont, '\(:h\)\@<=\d\+$')
      let l:gf_size_whole = l:gf_size_whole - 1
      let l:new_font_size = ':h'.l:gf_size_whole
      let &guifont = substitute(&guifont, ':h\d\+$', l:new_font_size, '')
    endfunction
endif

" copy clipboard
nnoremap <Leader>pp "+pp
nnoremap <Leader>yy "+yy
nnoremap <Leader>p ggVG"+p
nnoremap <Leader>y ggVG"+y
if has('win32')
  nmap <Leader>yp :let @+=substitute(expand("%"), "/", "\\", "g")<CR>
  nmap <Leader>yf :let @+=substitute(expand("%:p"), "/", "\\", "g")<CR>

  " This will copy the path in 8.3 short format, for DOS and Windows 9x
  nmap <Leader>y8 :let @+=substitute(expand("%:p:8"), "/", "\\", "g")<CR>
else
  nmap <Leader>yp :let @+=expand("%")<CR>
  nmap <Leader>yf :let @+=expand("%:p")<CR>
endif

map <C-n> :NERDTreeToggle<CR>

"  saving shortcut
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>
nnoremap zx :wq<cr>
inoremap zx <Esc>:wq<cr>

" Disable arrow
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

if has("cscope")
    set csprg=cscope.exe
    set csto=0
    set cst
    set csverb
    set nocscopeverbose
    " C symbol
    nnoremap <leader>r :cs find s <C-R>=expand("<cword>")<CR><CR>
    " file
    nnoremap <leader>o :cs find f <C-R>=expand("<cfile>")<CR><CR>
    " files #including this file
    nnoremap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>

    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

" tags
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" comment
:vmap <F5> :s:^://<CR>
:nnoremap <F5> :s:^://<CR>

if has("gui_running")
    nmap <S-F12> :call FontSizeMinus()<CR>
    nmap <F12> :call FontSizePlus()<CR>
endif

