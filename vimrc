" Install Plug and PLugs if they don't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'wimstefan/vim-artesanal'
Plug 'fcevado/molokai_dark'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ajh17/VimCompletesMe'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
call plug#end()

" Added color support
if $TERM == "xterm-256color"
  set t_Co=256
endif

set number
syntax on
set autoindent
colorscheme artesanal
set tabstop=2
set softtabstop=2
set laststatus=2
set showcmd

" Airline
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1

" Ale
let g:ale_sign_column_always = 0
let g:ale_fixers = {}
let g:ale_fixers.javascript = ['eslint']
let g:ale_javascript_eslint_executable = '.eslintrc.json'
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"

" vim-jsx
let g:jsx_ext_required = 1

" Auto whitespace trimming on write
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" Adds periods to whitespace
set list listchars=trail:.,extends:>
autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()
