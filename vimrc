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
set backspace=indent,eol,start
call plug#begin('~/vimfiles/plugged')
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'chrisbra/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdcommenter'
  Plug 'burntsushi/ripgrep'
  Plug 'felikz/ctrlp-py-matcher'
  Plug 'neoclide/coc.nvim', {'branch': 'release'} "https://releases.llvm.org/download.html
  Plug 'juneedahamed/vc.vim'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'
  Plug 'chrisbra/changesplugin'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
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
inoremap <c-v> <esc>:set paste<cr>a<c-r>=getreg('+')<cr><esc>:set nopaste<cr>mi`[=`]`ia
cmap <C-V> <C-R>+
vnoremap <C-C> "+y
vnoremap <C-V> "+p

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

" eacape remap
inoremap <C-X> <Esc>

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
    " search helper
    nnoremap <leader>s :cs find 

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

"fzf
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" vcs diff
let g:changes_vcs_check = 1
let g:gutentags_cache_dir = $HOME

" comment
autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

" Switch window
nnoremap <F2> <C-W>W
nmap <F8> :TagbarToggle<CR>
if has("gui_running")
    nmap <S-F12> :call FontSizeMinus()<CR>
    nmap <F12> :call FontSizePlus()<CR>
endif

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
" Vim with all enhancements
" source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

