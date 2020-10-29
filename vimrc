" Install Plug and Plugs if they don't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline-themes'
Plug 'liuchengxu/space-vim-dark'
" Plug 'thaerkh/vim-indentguides'
Plug 'vim-airline/vim-airline'
Plug 'pangloss/vim-javascript'
Plug 'jiangmiao/auto-pairs'
Plug 'ajh17/VimCompletesMe'
Plug 'keith/swift.vim'
Plug 'mxw/vim-jsx'
call plug#end()

" Added color support
if $TERM == "xterm-256color"
  set t_Co=256
endif

" Theming
colorscheme space-vim-dark
hi Comment cterm=italic
hi Comment guifg=#5C6370 ctermfg=59
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
set laststatus=2
set showcmd

let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" Auto whitespace trimming on write
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" Adds chars to whitespace and removed trailing
set list listchars=trail:∙,tab:»\ ,precedes:←,extends:→
autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()
