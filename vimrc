" Install Plug and Plugs if they don't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'liuchengxu/space-vim-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'ajh17/VimCompletesMe'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

" Added color support
if $TERM == "xterm-256color"
  set t_Co=256
endif

" Theming
colorscheme space-vim-dark
hi Comment cterm=italic
let g:space_vim_dark_background = 233
color space-vim-dark
" Airline
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

" UI args
set number
syntax on
set autoindent
set tabstop=2
set softtabstop=0
set shiftwidth=2
"autocmd Filetype javascript setlocal ts=4 sw=2 sts=0 noexpandtab
set laststatus=2
set showcmd

" Auto whitespace trimming on save
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" Adds chars to whitespace and removes trailing
autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()
