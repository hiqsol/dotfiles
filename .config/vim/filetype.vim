" for crontab editing
au! FileType crontab setlocal bkc=yes

au! BufNewFile,BufRead *.phl,*.pht,.php_cs      set filetype=php
au! BufNewFile,BufRead *.sql,*.SQL              set filetype=sql
au! BufNewFile,BufRead *.tpl,*.tmpl,*.xml.dist  set filetype=xml
au! BufNewFile,BufRead *.md                     set filetype=markdown
au! BufNewFile,BufRead composer.lock            set filetype=json
au! BufNewFile,BufRead docker-compose.yml.*     set filetype=yaml
au! BufNewFile,BufRead .env.*                   set filetype=sh

au FileType php let b:syntastic_php_phpmd_args =
    \ @% . ' text /home/sol/.vim/php/phpmd.xml'

au FileType tagbar,nerdtree setlocal signcolumn=no

au FileType yaml        setlocal ts=2 sw=2
au FileType html        setlocal ts=2 sw=2
au FileType javascript  setlocal ts=2 sw=2
au FileType jsonnet     setlocal ts=2 sw=2
