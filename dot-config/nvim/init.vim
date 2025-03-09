" Install Plug and Plugs if they don't exist
" spellchecker: disable
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    source '~/.config/nvim/autoload/plug.vim' " this needs to be added
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" Themeing
Plug 'vim-airline/vim-airline-themes'
Plug 'olimorris/onedarkpro.nvim'
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'mhinz/vim-signify'

" Utils
Plug 'Yggdroot/indentLine'
Plug 'vim-scripts/VimCompletesMe'

" Lang Support
Plug 'sheerun/vim-polyglot'
Plug 'adityastomar67/italicize'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Vim status in gutter
Plug 'airblade/vim-gitgutter'
call plug#end()

" Theming
set termguicolors
colorscheme onedark_vivid

" Airline
let g:airline_theme='powerlineish'
let g:airline_powerline_fonts = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''

" Indent
let g:indentguides_ignorelist = ['text']
let g:indentLine_char = '▏'

" Git gutter
let g:signify_sign_add = '│'
let g:signify_sign_delete = '│'
let g:signify_sign_change = '│'
hi DiffDelete guifg=#ff5555 guibg=none

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
set clipboard=unnamedplus
set backspace=indent,eol,start
inoremap jk <ESC>

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

" Syntax highlighing for compose files
autocmd bufread,bufnewfile compose*.{yaml,yml}* set ft=yaml.docker-compose

" Syntax highlighing for alias files
autocmd bufread,bufnewfile .*aliases set ft=sh

" Adds chars to whitespace and removes trailing
set list listchars=trail:∙,tab:»\ ,precedes:←,extends:→
autocmd FileWritePre * call TrimWhiteSpace()
autocmd FileAppendPre * call TrimWhiteSpace()
autocmd FilterWritePre * call TrimWhiteSpace()
autocmd BufWritePre * call TrimWhiteSpace()
