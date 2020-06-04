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
set number
set numberwidth=5


call plug#begin('~/vimfiles/plugged')
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'chrisbra/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-fugitive'
  Plug 'itchyny/lightline.vim'
  Plug 'valloric/youcompleteme'
  Plug 'morhetz/gruvbox'
  Plug 'scrooloose/nerdcommenter'
  Plug 'burntsushi/ripgrep'
  Plug 'lyuts/vim-rtags'
  Plug 'mbbill/undotree'
  Plug 'leafgarland/typescript-vim'
call plug#end()

colorscheme gruvbox
let g:gruvbox_contrast_dark='soft'

if executable('rg')
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
    let g:rg_derive_root='true'
endif
" Sane Ignore For ctrlp
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$\|\.patch$\|\.cmake$\|\.zip$\|\.png$\|\.in$\|\.out$\'
  \ }
let g:ctrlp_max_files = 0
let ctrlp_lazy_update=1
let ctrlp_clear_cache_on_exit=0
let ctrlp_by_filename=1
set mmp=5000

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

"YCM
let g:ycm_confirm_extra_conf=0 "'%USERPROFILE%\vimfiles\plugged\youcompleteme\third_party\ycmd\cpp\ycm\.ycm_extra_conf.py'
nnoremap <leader>gh :YcmCompleter GoToInclude<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gi :YcmCompleter GoToDefinition<CR>
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>gf :YcmCompleter GoToImprecise<CR>

" copy clipboard
nnoremap <Leader>pp "+pp
nnoremap <Leader>yy "+yy
nnoremap <Leader>p ggVG"+p
nnoremap <Leader>y ggVG"+y

" Map Ctrl + p to open fuzzy find (FZF)
nnoremap <c-p> :Files<cr>

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

if has("gui_running")
    nmap <S-F12> :call FontSizeMinus()<CR>
    nmap <F12> :call FontSizePlus()<CR>
endif
