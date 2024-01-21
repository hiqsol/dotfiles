" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let mysyntaxfile    = "~/.vim/syntax.vim"
let myfiletypefile  = "~/.vim/filetype.vim"

source ~/.vim/plugins.vim
source ~/.vim/options.vim
source ~/.vim/functions.vim
source ~/.vim/keys.vim

let mainlocalconfig = "~/.vim/local.vim"
if filereadable(glob(mainlocalconfig))
    execute 'source' mainlocalconfig
endif

let prjlocalconfig = '.local.vim'
for i in [1, 2, 3, 4, 5]
    if filereadable(glob(prjlocalconfig))
        execute 'source' prjlocalconfig
    endif
    let prjlocalconfig = '../' . prjlocalconfig
endfor
