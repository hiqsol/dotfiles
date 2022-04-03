" Configuration
set exrc                        " per-project configuration file
set secure                      " disable unsafe commands
set maxmempattern=1500          " prevent E363: pattern uses more memory than 'maxmempattern'

" Indending
set autoindent
set smartindent
set tabstop=4                   " number of spaces that a <Tab> in the file counts for
set softtabstop=-1              " number of spaces that a <Tab> counts for while performing editing operations
set shiftwidth=0                " number of spaces to use for each step of (auto)indent
set expandtab                   " use the appropriate number of spaces to insert a <Tab>
set smarttab
set bs=2                        " allow backspacing over everything in insert mode
set textwidth=160

" save, undo & backup
set autowriteall                " write file on file commands
set updatetime=1000             " faster saving swap file
set undofile                    " allows undo after reopen file
set undodir=~/.vim/undo//
set backup                      " keep a backup file
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set viminfo='20,\"50            " read/write a .viminfo file, don't store >50 lines of registers
set viminfo+=n~/.vim/viminfo    " viminfo file path
set history=999                 " keep given lines of command line history
set hidden                      " required for operations modifying multiple buffers like rename

" HUD
set lazyredraw                  " really faster redrawing
set ruler                       " show the cursor position all the time
set norelativenumber            " don't show relative line numbers
set nonumber                    " don't show absolute line
set cursorline                  " show cursor line
set showtabline=2               " always show tabline
set laststatus=2                " always show status line
set scrolloff=2                 " keep 2 lines before scroll
set sidescrolloff=5             " keep 5 columns before horizontal scroll
set diffopt+=vertical           " allows vertical diff
set shortmess+=c                " don't pass messages to ins-completion-menu

" Search
set path+=**                    " `:find` down into subfolders
set wildmenu                    " command-line completion with menu
set wildmode=longest:full,full
set ignorecase
set smartcase
set hlsearch                    " highlight search

if has('gui_running')
    source gui.vim
endif

let g:netrw_browsex_viewer="local-open"
