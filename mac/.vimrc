"  ____  __.____ ____   _________________________
"  |    |/ _|    |\   \ /   /\__    ___/\____    /
"  |      < |    | \   Y   /   |    |     /     /
"  |    |  \|    |__\     /    |    |    /     /_
"  |____|__ \_______ \___/     |____|   /_______ \
"          \/       \/                          \/
"
" ----------------------------------------------------------------------------
" Normal Setters and Letters
" ----------------------------------------------------------------------------
set nocompatible
filetype plugin indent on
syntax on

call pathogen#infect()

let mapleader = ","
set ignorecase
set hlsearch
set fileencoding=utf-8
set encoding=utf-8
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartcase
set gdefault
set incsearch
set showmatch
set noswapfile
set visualbell
set cursorline
set hidden
set linebreak
set scrolloff=5
set showcmd
set number
set term=screen-256color
set background=dark
set t_Co=256
set autoindent
set smartindent
set laststatus=2
set ttimeoutlen=50
set textwidth=80

highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" ControlP plugin
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Invisible chars
set listchars=eol:¬

" ----------------------------------------------------------------------------
" Colorscheme and settings for styling
" ----------------------------------------------------------------------------

colorscheme base16-ashes
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
" ----------------------------------------------------------------------------
" Abbreviations
" ----------------------------------------------------------------------------

cnoreabbrev wrap set wrap
cnoreabbrev nowrap set nowrap
"
" artisan generator
abbrev gm !php artisan generate:model
abbrev gc !php artisan generate:controller
abbrev gmig !php artisan generate:migration

" ----------------------------------------------------------------------------
" Mappings
" ----------------------------------------------------------------------------

"mapping for correct regular expression under magic mode
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

"Easy escapping to normal mode
inoremap jj <esc>

"Auto change directory to match current file ,cd
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" toggle NERDTree
nnoremap <C-b> :NERDTreeToggle<CR>

" ctags generator
nnoremap <f8> :!ctags -R .<cr>

" hide currently highlighted search
nnoremap <leader><space> :noh<cr>

" turn on EOL symbol
nmap <leader>l :set list!<CR>

" Gundo for branching diff within file history
nnoremap <F6> :GundoToggle<CR>

" Redraw vim console when we are in tmux
nnoremap <F4> :redraw!<CR>

" easier window navigation
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Delete whitespace
nnoremap <leader>W mz:%s/\s\+$//<CR>:let @/=''<CR>`z

" Reindent file
nnoremap <leader>ef mfgg=G`z<CR>

" Edit todo list for projects
nmap ,todo :e todo.txt<cr>

" Practice muscle memory for using the h j k l keys for direction.
noremap <left> <nop>
noremap <right> <nop>
noremap <up> <nop>
noremap <down> <nop>

" Map Goyo toggle to <leader> + z
nnoremap <Leader>z :Goyo<CR>

" Toggle spell checking on and off with `,s`
nmap <silent> <leader>s :set spell!<CR>

" Toggle Syntastic
nnoremap <F9> :SyntasticToggleMode<CR>

" Bubble up Text
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

" Easy Align
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" CtrlP mapping --fuzzy searching
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" optional setting for not pulling up these folders/files when calling CtrlP
" Laravel specific
set wildignore+=*/vendor/**
set wildignore+=*public/forum/**

" airline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" ----------------------------------------------------------------------------
" Custom Commands
" ----------------------------------------------------------------------------

" Captial W and Q for write and quit
:command! WQ wq
:command! Wq wq
:command! Q q
:command! W w
:command! Bn bn
:command! Bp bp

" Open Vim on startup, left.
" autocmd VimEnter * NERDTree
" let g:NERDTreeWinPos = "left"

" soft wrapping
command! -nargs=* Wrap set wrap linebreak nolist

"Laravel 4 Snippet loader under PHP
" autocmd FileType php set ft=php.laravel

" Goyo reload settings on exit
autocmd! User GoyoLeave
autocmd User GoyoLeave nested source $MYVIMRC | silent loadview

" Only do this part when compiled with support for autocommands
if has("autocmd")
	" Syntax of these languages languages is fussy over tabs Vs spaces
	autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
	autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
	" Customisations based on house-style (arbitrary)
	autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

	" Treat .rss files as XML
	autocmd BufNewFile,BufRead,BufNew *.rss setfiletype xml
	autocmd BufNewFile,BufRead,BufNew *.md set filetype=markdown
endif

" Fix 256-color in tmux and vim
if &term =~ '256color'
	set t_ut=
endif