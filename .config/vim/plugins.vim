" PLUG installation
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Editing plugins
Plug 'foosoft/vim-argwrap'
Plug 'vim-scripts/auto-pairs-gentle'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-easy-align'

" HUD plugins
Plug 'bling/vim-airline'
Plug 'ervandew/supertab'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/fzf',                            {'dir': '~/.config/fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'mbbill/undotree',                         {'on': 'UndotreeToggle'}
Plug 'scrooloose/nerdtree',                     {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'romainl/vim-qf'
Plug 'valloric/listtoggle'
Plug 'blueyed/vim-diminactive'

" Grep
Plug 'dkprice/vim-easygrep'
Plug 'mileszs/ack.vim'
Plug 'blueyed/vim-qf_resize'

" Shell helpers
Plug 'edkolev/promptline.vim',                  {'on': 'PromptlineSnapshot'}
Plug 'rkitover/vimpager',                       {'on': 'Never'}

" Git plugins
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'junegunn/gv.vim'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'Xuyuanp/nerdtree-git-plugin',             {'on': ['NERDTreeToggle', 'NERDTreeFind']}

" REST
Plug 'aquach/vim-http-client'
Plug 'diepm/vim-rest-console'

" DB
" Plug 'tpope/vim-dadbod'
Plug 'vim-scripts/dbext.vim',                   {'for': ['sql', 'pgsql']}

" Programming plugins
Plug 'neoclide/coc.nvim',                       {'branch': 'release'}
Plug 'joonty/vdebug',                           {'on': 'VdebugRun'}
Plug 'majutsushi/tagbar',                       {'on': 'TagbarToggle'}
Plug 'michaeljsmith/vim-indent-object'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'

" PHP plugins
Plug 'alvan/vim-php-manual',                    {'for': 'php'}
Plug 'everzet/phpfolding.vim',                  {'for': 'php'}
Plug 'StanAngeloff/php.vim',                    {'for': 'php'}
Plug 'vim-scripts/PDV--phpDocumentor-for-Vim',  {'for': 'php'}
Plug 'stephpy/vim-php-cs-fixer',                {'for': 'php'}
Plug 'noahfrederick/vim-composer',              {'for': 'php'}

" Syntax highlighting plugins
Plug 'lifepillar/pgsql.vim',                    {'for': 'pgsql'}
Plug 'aklt/plantuml-syntax',                    {'for': 'plantuml'}
Plug 'solarnz/thrift.vim',                      {'for': 'thrift'}
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
"Plug 'sheerun/vim-polyglot'
"Plug 'elzr/vim-json',                           {'for': 'json'}
"Plug 'hiqsol/pgsql.vim',                        {'for': 'pgsql'}
"Plug 'hiqsol/vim-markdown',                     {'for': 'markdown'}
"Plug 'lumiliet/vim-twig',                       {'for': 'html.twig'}

" Snippets
Plug 'SirVer/ultisnips'                         " snippet runner
Plug 'honza/vim-snippets'                       " snippets library

" ZSH plugins
Plug 'zsh-users/zsh-autosuggestions'

" Other
Plug 'vimwiki/vimwiki'
Plug 'voldikss/vim-translator'

" Rejected plugins
"Plug 'jiangmiao/auto-pairs'
"Plug 'vim-scripts/LargeFile'                   " better large files support, didn't help
"Plug 'mkitt/tabline.vim'                       " shows tab number, filename and [+], substituted with vim-airline
"Plug 'joonty/vim-phpqa'                        " show code coverage
"Plug 'roxma/python-support.nvim'               " doesn't help, seems to make worse
"Plug 'jistr/vim-nerdtree-tabs',                " no need with FZF
"Plug 'scrooloose/syntastic'                    " substituted with ALE

" Language server
"Plug 'autozimu/LanguageClient-neovim',         {'branch': 'next', 'do': 'bash install.sh'}
"Plug 'roxma/LanguageServer-php-neovim',        {'do': 'composer install && composer run-script parse-stubs'}

" NCM Completion
"Plug 'roxma/nvim-completion-manager'
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'                          " Yet Another Remote Plugin Framework for Neovim
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'

call plug#end()

" Plugin options
let g:vimpager_passthrough = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeIgnore = ['\~$', '\.pyc$', '\.swp$']
let g:markdown_fenced_languages = ['php', 'python', 'sh', 'css', 'javascript', 'js=javascript', 'json=javascript', 'yaml', 'yml=yaml', 'xml']
let g:LanguageClient_autoStart = 0

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:lt_location_list_toggle_map = '\l'
let g:lt_quickfix_list_toggle_map = '\q'
let g:SuperTabDefaultCompletionType = '<C-N>'
let g:SuperTabNoCompleteAfter = ['^', '\s', '"', "'", ',', '.', ':']
let g:ale_sign_warning = '⇒ '
let g:airline#extensions#ale#enabled = 1
let g:php_cs_fixer_rules = "@PSR2"
let g:php_cs_fixer_config_file = '/home/sol/.vim/php/php_cs.php'

" Vdebug
let g:vdebug_options = {
\   'timeout': 60,
\   'path_maps': {
\       "/app": getcwd()
\   }
\}

" UltiSnips
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories = ['UltiSnips']

" Git
let g:fugitive_gitlab_domains = ['https://git.hiqdev.com']

" DBext
let g:dbext_default_prompt_for_parameters = 0
let g:dbext_default_history_file = '~/.vim/dbext_sql_history.txt'

" Grep
if executable('rg')
    let &grepprg = 'rg --vimgrep'
    let g:ackprg = 'rg --vimgrep'
else
    let &grepprg = 'grep -IR'
    let g:ackprg = 'grep -IR'
endif
"let g:ackprg = 'ag --nogroup --nocolor --column'
let g:qf_resize_max_height = 40
let g:qf_resize_max_ratio  = 0.5
let g:EasyGrepCommand = 1
let g:EasyGrepRoot = 'search:\.'

" VimWiki
let g:vimwiki_list = [{'path': '~/src/memo/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_table_mappings=0

" Translator
let g:translator_target_lang = 'ru'

" Auto-pairs
let g:AutoPairsShortcutToggle = ''
