syntax on

filetype on           " Enable filetype detection

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set number
set mouse=a
set clipboard=exclude:.*

" Search
set hlsearch		" search highlighting
set showmatch		" Cursor shows matching ) and }
set ignorecase
set smartcase

set showmode		" Show current mode

" Indentation
filetype indent on    " Enable filetype-specific indenting
set autoindent		" auto indentation
set copyindent		" copy the previous indentation on autoindenting
set expandtab        "replace <TAB> with spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smarttab

au FileType Makefile set noexpandtab

" yaml
au BufNewFile,BufRead *.yml set tabstop=2
au BufNewFile,BufRead *.yml set shiftwidth=2
au BufNewFile,BufRead *.yml set softtabstop=2

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Make it obvious where 80 characters is
"set textwidth=80
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

