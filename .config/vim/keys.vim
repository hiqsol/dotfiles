" KEYS. Available ctrls for later use: <C-N>
" unusable: CTRL-[, CTRL-H, CTRL-M (Esc, Backspace, Enter)
" see `:help keycodes` and `:help map-which-keys`

let mapleader="\\"

" Make p in Visual mode replace the selected text with the "" register.
vnoremap    p           <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" mouse paste without auto indenting
nnoremap    \R          :r! cat<CR>

" different editing
nnoremap    ci<         cit
nnoremap    zr          zR
nnoremap    zR          zr
nnoremap    zm          zM
nnoremap    zM          zm
nnoremap    \ps         vip:!sort<CR>
nnoremap    Y           y$
nnoremap    <A-p>       gp
nnoremap    <A-P>       gP
nnoremap    <M-p>       gp
nnoremap    <M-P>       gP
vmap        ga          <Plug>(EasyAlign)
nmap        ga          <Plug>(EasyAlign)

" Remap increase/decrease number to free C-A, C-X
nnoremap    <A-a>       <C-A>
vnoremap    <A-a>       <C-A>
nnoremap    <A-x>       <C-X>
vnoremap    <A-x>       <C-X>

" Search keys
nnoremap    *           *N
nnoremap    <M-/>       /\c
nnoremap    \<Space>    /\t\+ \+\\| \+\t\+\\|\s\+$/<CR>
nnoremap    \/          /\<\><Left><Left>
nnoremap <silent>   \\  :nohlsearch<CR>
nnoremap    gh          :Rg<Space>
nnoremap    gr          :Ack!<Space>
nnoremap    gp          :Ack!<Space>--type php<Space>
nnoremap    g8          :Ack!<Space><C-R><C-W><CR>
nmap        <M-8>       <Plug>EgMapGrepCurrentWord_v

" Movement keys like in shell
noremap     <C-A>       <Home>
noremap     <C-E>       <End>
inoremap    <C-A>       <Home>
inoremap    <C-E>       <End>
inoremap    <C-J>       <Down>
inoremap    <C-K>       <Up>
inoremap    <C-L>       <Right>

" Windows/Tabs
nnoremap    <C-W>a      :tabnew<Space>
nnoremap    <C-W>e      :e<CR>
nnoremap    <C-W>O      :tabonly<CR><C-W>o
nnoremap    <C-W>Q      :qa<CR>
nnoremap    <C-W>u      <C-W>t<C-W>l
nnoremap    <C-W><Tab>  :tabnew<CR>
nnoremap    <C-W>x      :tabclose<CR>
nnoremap    <C-W>z      <C-W>o200<C-W>+
nnoremap    <M-1>       1gt
nnoremap    <M-2>       2gt
nnoremap    <M-3>       3gt
nnoremap    <M-4>       4gt
nnoremap    <M-5>       5gt

" HUD keys
nnoremap    <C-S>       :wa<CR>
nnoremap    <C-X>       :close<CR>
nnoremap    <C-J>       :BLines<CR>
nnoremap    <C-K>       :FZFMru<CR>
nnoremap    <C-P>       :FZF<CR>
nnoremap    z8          :FZF -q <C-R><C-W><CR>
nnoremap    <C-L>       :GitGutterAll<CR><C-L>
nnoremap    <C-G>       :echo expand('%:p')<CR>
nnoremap    <C-F>       :call ToggleLeft()<CR>
nnoremap    <C-N>       :call NerdTreeToggleFind()<CR>
nnoremap    \u          :UndotreeToggle<CR>
nnoremap    \m          :Maps<CR>
nnoremap                'm      :messages<CR>
nmap        <silent>    'q      <Plug>(qf_qf_toggle)
nmap        <silent>    'l      <Plug>(qf_loc_toggle)

" Git keys
nnoremap    gl          :0Gclog<CR>
nnoremap    gb          :Git blame<CR>
nnoremap    gD          :Git diff<CR>
nnoremap    gd          :Gdiffsplit<CR>
nnoremap    gs          :Git status<CR>
nnoremap    gc          :Git commit --verbose<CR>
nnoremap    go          :GBrowse<CR>
nnoremap    gO          :GBrowse!<CR>
vnoremap    go          :GBrowse<CR>
vnoremap    gO          :GBrowse!<CR>
nnoremap    gw          :Gwrite<CR>
nnoremap    gub         :Git pull --rebase<CR>
nnoremap    guh         :Git push<CR>

" Programming keys
nmap        <C-C>       <Plug>NERDCommenterToggle
vmap        <C-C>       <Plug>NERDCommenterToggle
nnoremap    \cd         :call PhpDocSingle()<CR>
vnoremap    \cd         :call PhpDocRange()<CR>
nnoremap    \T          :TagbarToggle<CR>
nnoremap    \w          :ArgWrap<CR>
nnoremap    <F5>        :VdebugRun<CR>
"nnoremap    co          :Composer<Space>
inoremap <expr> <C-]>   CompletePhpClass()
nnoremap <silent> <C-]> :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> <C-\> :call CocActionAsync('jumpReferences')<CR>
nnoremap    \am          :AsyncRun make<Space>
nnoremap    \al          :AsyncRun <Up><CR>

" DB keys
nnoremap    \sx         :DBExecSQLUnderCursor<CR>
vnoremap    \sx         :DBExecRangeSQL<CR>
nnoremap    \sp         vip:DBExecRangeSQL<CR>
nnoremap    \sh         :call ShowDbextSettings()<CR>
" nnoremap    \sx         :DB g:dadbod_default<CR>
" vnoremap    \sx         :DB g:dadbod_default<CR>
" nnoremap    \sp         vip:DB g:dadbod_default<CR>

" etc plugins
nnoremap    \r          :HTTPClientDoRequest<CR><C-W>W
nmap        't          <Plug>TranslateW
vmap        't          <Plug>TranslateWV
