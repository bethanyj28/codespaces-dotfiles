"------------------------------------------------------------------------------
" Plugins

call plug#begin('~/.vim/plugged')
" Rust tools
Plug 'rust-lang/rust.vim'
" Go tools
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Linter
Plug 'w0rp/ale'
" Display errors
Plug 'vim-airline/vim-airline' 
" Typescript syntax
Plug 'https://github.com/leafgarland/typescript-vim'
" Easy blaming
Plug 'zivyangll/git-blame.vim'
" Gruvbox theme
Plug 'gruvbox-community/gruvbox'
" Flake8 python syntax/style checker
Plug 'https://github.com/nvie/vim-flake8'
" AutoPairs auto close brackets, quotes, etc
Plug 'https://github.com/jiangmiao/auto-pairs'
" Make everything pretty
Plug 'sheerun/vim-polyglot'
" Easy commenting
Plug 'https://github.com/tpope/vim-commentary'
" Git good
Plug 'https://github.com/tpope/vim-fugitive'
" Terraform QOL improvements
Plug 'https://github.com/hashivim/vim-terraform'
" Fuzzy wuzzy file finding
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

"------------------------------------------------------------------------------
" Mappings

" Mapleader setting
let mapleader = ","

" Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Vim Git Blame
map <leader>b :<C-u>call gitblame#echo()<CR>

" Use jk as ESC in insert mode
inoremap jk <Esc>

"------------------------------------------------------------------------------
" Features

" Sanely reset options when re-sourcing .vimrc
set nocompatible

" Determine filetype and allow auto-indenting
filetype indent plugin on

"Enable syntax highlighting
syntax on

"Encoding
set encoding=utf-8

"NerdTree
let NERDTreeShowHidden=1 " show the hidden things
let NERDTreeIgnore=['\.DS_Store$', '\.git$'] " ...but not all the hidden things
"-----------------------------------------------------------------------------
" Usability options

" Re-use the same window and switch from an unsaved buffer without saving
" first. Keeps an undo history for multiple files when re-using the same
" window
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches
set hlsearch

" Use case insensitive search except when using caps
set ignorecase
set smartcase

" Copy text in visual mode to clipboard
noremap <leader>y "+y

" Paste text in from keyboard in visual mode
noremap <leader>p "+p

" Allow backspacing over autoindent, line breaks, and start of insert action
set backspace=indent,eol,start

" When opening new line and no filetype-specific indenting is enabled, keep the
" same indent as the current line.
set autoindent

" Stop certain movements from always going to the first character of a line
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line
set laststatus=2

" Raise a dialog when quitting without saving instead of failing a command
set confirm

" Don't be very annoying
set visualbell

" Don't be slightly annoying
set t_vb=

" Display line numbers
set number

" Display line number relative to current line
set relativenumber

" Click normally with mouse
set mouse=a

" Navigate errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Easier window switching
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

"------------------------------------------------------------------------------
" Ale (linting) customizations
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Setting linters
let g:ale_linters = {}
let g:ale_linters.javascript = ['prettier', 'eslint']
let g:ale_linters.typescript = ['prettier', 'eslint']
let g:ale_linters.python = ['flake8']

" Ignore things like the line being too long and so on
let g:ale_python_flake8_options = '--ignore=E501,E261,E126,E302'

" Airline plug integration
let g:airline#extensions#ale#enabled = 1

" Show x lines of errors (default: 10)
let g:ale_list_window_size = 3

" Fix my mistakes
let g:ale_fix_on_save = 1

" automatic imports
let g:ale_completion_autoimport = 1

" Make vim-go tell me all the errors
nnoremap <F6> :w <CR> :GoTestCompile <CR> <CR>
inoremap <F6> <ESC> :w <CR> :GoTestCompile <CR> <CR>
let g:go_metalinter_autosave=1
let g:go_metalinter_autosave_enabled=['golint', 'govet']
"------------------------------------------------------------------------------
" Terraform options
let g:terraform_align=1
let g:terraform_fmt_on_save=1
"------------------------------------------------------------------------------
" Terraform options
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>t :term<CR>
"------------------------------------------------------------------------------
" vim-go options
nnoremap <leader>bp :GoDebugBreakpoint<CR>
nnoremap <leader>c :GoDebugContinue<CR>
nnoremap <leader>n :GoDebugNext<CR>
nnoremap <leader>s :GoDebugStep<CR>
"------------------------------------------------------------------------------
" Indentation options

" Indent with 2 spaces instead of tabs
setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype go setlocal expandtab tabstop=8 shiftwidth=8 softtabstop=8
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2


"------------------------------------------------------------------------------
" Color scheme
colorscheme gruvbox

"------------------------------------------------------------------------------
" Make ctrlP faster
if executable('rg')
  let g:ctrlp_user_command = 'rg %s --files --hidden --color=never --glob ""'
endif
