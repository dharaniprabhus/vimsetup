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
set nowrap " do not wrap on load
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set undodir=~/.vim/undo
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

call plug#begin('~/.vim/plugged')
  Plug 'chrisbra/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'
  Plug 'burntsushi/ripgrep' "https://github.com/BurntSushi/ripgrep/releases
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'juneedahamed/vc.vim'
  Plug 'puremourning/vimspector'
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'majutsushi/tagbar'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'tpope/vim-repeat'
  Plug 'chiel92/vim-autoformat'
  Plug 'morhetz/gruvbox'
call plug#end()

set background=light
let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

"https://releases.llvm.org/download.html
let g:coc_global_extensions = [
            \'coc-highlight',
            \'coc-python',
            \'coc-json', 
            \"coc-clangd"
            \]

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
map <C-m> :NERDTreeFind<CR>

inoremap kj <Esc>
"  saving shortcut
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>
nnoremap zx :wq<cr>
inoremap zx <Esc>:wq<cr>
nnoremap <leader>ca <C-W><C-O>

" Disable arrow
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

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
" let g:gutentags_cache_dir = $HOME


" Switch window
nnoremap <F2> <C-W>W
nmap <leader>t :TagbarToggle<CR>
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
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <plug>(coc-rename) 
nmap <leader>qf <plug>(coc-fix-current)
nnoremap <leader>prr :CocSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>ld :CocDiagnostics <CR><CR>

if has("clangd")
    nnoremap <leader>gi :CocCommand clangd.switchSourceHeader<CR><CR>
else
    nnoremap <leader>gi :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
endif


let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <silent> <C-h> :Files /opt/mgu22/sysroots/aarch64-poky-linux/usr/include/<CR>

augroup grp
    autocmd!
    " quickfix
    autocmd FileType qf if mapcheck('<esc>', 'n') ==# '' | nnoremap <buffer><silent> <esc> :cclose<bar>lclose<CR> | endif
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

    " clang-format needs to installed
    autocmd BufWritePre *.h,*.cc,*.cpp :Autoformat

    " comment
    autocmd FileType c,cpp,cs,java setlocal commentstring=//\ %s

    " highlight
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END
