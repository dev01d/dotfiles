" Install Plug and Plugs if they don't exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" Themeing
Plug 'vim-airline/vim-airline-themes'
Plug 'liuchengxu/space-vim-dark'
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'mhinz/vim-signify'

" Utils
Plug 'Yggdroot/indentLine'
Plug 'ajh17/VimCompletesMe'

" Lang Support
Plug 'arzg/vim-sh'
Plug 'yuezk/vim-js'
Plug 'fatih/vim-go'
Plug 'keith/swift.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'airblade/vim-gitgutter'

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
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''

"  Indent
let g:indentguides_ignorelist = ['text']
let g:indentLine_char = '▏'

" Git gutter
let g:signify_sign_add = '│'
let g:signify_sign_delete = '│'
let g:signify_sign_change = '│'
hi DiffDelete guifg=#ff5555 guibg=none

let g:syntastic_swift_checkers = ['swiftpm', 'swiftlint']

" UI args
syntax on
set number
set showcmd
set mouse+=a
set tabstop=2
set expandtab
set autoindent
set laststatus=2
set shiftwidth=2
set softtabstop=2
set rtp+=/usr/local/opt/fzf
set backspace=indent,eol,start

" Auto whitespace trimming on write
function TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction

" Syntax highlight for my Dockerfile naming scheme
augroup docker_ft
  au!
  autocmd BufNewFile,BufRead Dockerfile.*  set syntax=dockerfile
augroup END

" Adds chars to whitespace and removes trailing
set list listchars=trail:∙,tab:»\ ,precedes:←,extends:→
autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()

