
call plug#begin('~/.vim/plugged')
  Plug 'Shougo/neocomplcache.vim'
  Plug 'Shougo/neocomplete.vim'
  Plug 'Shougo/neosnippet.vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  "Plug 'Shougo/vimfiler.vim'
  Plug 'Xuyuanp/nerdtree-git-plugin'

  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'

  "Plug 'ap/vim-css-color'
  Plug 'chrisbra/Colorizer'
  Plug 'kablamo/vim-git-log'

  Plug 'nerdrew/dart-vim-plugin'
  Plug 'yegappan/mru'
  "Plug 'szw/vim-ctrlspace'
  
  "Plug 'scrooloose/syntastic'
  "Plug 'int3/vim-taglist-plus'
  Plug 'arecarn/crunch.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'majutsushi/tagbar'
  Plug 'airblade/vim-gitgutter'
  Plug 'kien/ctrlp.vim'

  Plug 'bling/vim-airline'
  Plug 'morhetz/gruvbox'

  "Dart
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'osyo-manga/neocomplcache-snippets-complete-dart'
  Plug 'bartlomiejdanek/vim-dart'
  Plug 'loicfrering/vim-dart'
  
  "JavaScript
  Plug 'jelera/vim-javascript-syntax'
  Plug 'othree/javascript-libraries-syntax.vim'
  Plug 'pangloss/vim-javascript'

  "Plug 'jasmine/jasmine'
  "Plug 'jashkenas/coffeescript'

  "Ruby
  Plug 'vim-ruby/vim-ruby'

  "CSS
  Plug 'skammer/vim-css-color'
  
  Plug 'hail2u/vim-css3-syntax'
  "Plug 'eshion/vim-sftp-sync'
  Plug 'rstacruz/sparkup'
  Plug 'jeetsukumaran/vim-markology'
  "Plug 'Valloric/MatchTagAlways'
  Plug 'othree/html5.vim'
  Plug 'ervandew/supertab'
  "Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'tpope/vim-surround'
  Plug 'pangloss/vim-javascript'
  "Plug 'Lokaltog/vim-easymotion'
  Plug 'vitalk/vim-simple-todo'
  Plug 'tpope/vim-markdown'
  Plug 'mattn/emmet-vim'
  Plug 'Raimondi/delimitMate'
  "Plug 'fatih/vim-go'
  Plug 'tpope/vim-sensible'
  Plug '907th/vim-auto-save'
  Plug 'sjl/gundo.vim'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'elzr/vim-json'
  Plug 'powerman/vim-plugin-ruscmd'
  "Plug 'ierton/xkb-switch'
  Plug 'myshov/xkbswitch-macosx'
  Plug 'ryanoasis/vim-webdevicons'
  "Plug 'ironcamel/vimchat'
  Plug 'yuratomo/w3m.vim'
  Plug 'etnadji/vim-epub'
call plug#end()

let g:w3m#external_browser = 'chrome'
let g:w3m#homepage = "http://www.google.ru/"

let g:XkbSwitchEnabled = 1 
let g:XkbSwitchIMappings = ['ru']

let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1

colorscheme gruvbox
filetype plugin on
filetype on

set encoding=utf8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types 

"Airline
"let g:airline#extensions#tabline#enabled = 1

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▷'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_powerline_fonts = 1
"let g:airline_left_sep = '≻'
"let g:airline_right_sep = '≺'

let g:airline_theme='tomorrow'

"let g:auto_save = 1

"NeoComplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
      \ }
if !exists('g:neocomplete#keyword_patterns')
 let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'


" make YCM compatible with UltiSnips (using supertab)
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen = 1
let g:colorizer_auto_color = 1

set background=dark 
set spell
set linebreak 
set noswapfile
set backspace=indent,eol,start
set laststatus=2
set number
set incsearch
set hlsearch
set ignorecase
set smartcase
set termencoding=utf8
set nocompatible
set ruler
set showcmd
set foldenable
set foldlevel=100
set foldmethod=indent
set noerrorbells visualbell t_vb=

autocmd GUIEnter * set visualbell t_vb=
set spell spelllang=ru_yo
setlocal spell spelllang=ru_yo 
syntax enable

set t_Co=256
set ch=1
set autoindent
set wrap
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smartindent
set showmatch
"set lines=40
"set columns=140
set iskeyword=@,48-57,_,192-255
set history=200
set langmap=рh,оj,лk,дl,РH,ОJ,ЛK,ДL
set smarttab
set title
set autoread
set breakindent
set cursorline

let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'JavaScript',
    \ 'kinds'     : [
        \ 'o:objects',
        \ 'f:functions',
        \ 'a:arrays',
        \ 's:strings'
    \ ]
    \ }

let g:tagbar_type_css = {
      \ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
    \ }

let g:tagbar_type_scss = {
      \ 'ctagstype' : 'Scss',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
    \ }

if !exists("g:tagbar_type_dart")
  let g:tagbar_type_dart = {
      \ 'ctagsbin' : 'pub',
      \ 'ctagsargs' : ['global', 'run', 'dart_ctags:tags', '--skip-sort', '--line-numbers'],
      \ 'ctagstype' : 'dart',
      \ 'kinds'     : [
         \ 'c:classes',
          \ 'f:function',
         \ 'M:static method',
          \ 'm:method',
          \ 'i:field'
      \ ]
  \ }
endif

if has('vim_starting')
set nocompatible
      set runtimepath+=~/.vim/bundle/dart-vim-plugin
    endif
filetype plugin indent on

map <C-n> :NERDTreeToggle<CR>

"map boc :exe 'silent !open -a /Applications/Google\ Chrome.app %' <CR>

map <leader>] :tag /<c-r>=expand('<cword>')<cr><cr>
map <leader>} :ptag /<c-r>=expand('<cword>')<cr><cr>
map <leader>cp :CtrlPClearCache
nmap <leader>ne :NERDTree<cr>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    "echo 'Highlight current word: ON'
    return 1
  endif
endfunction

call AutoHighlightToggle() 

au BufReadCmd   *.epub      call zip#Browse(expand("<amatch>"))

"for paste: :r! cat
"for git log edit : git config --global core.pager 'vim -'
