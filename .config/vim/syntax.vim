" my additional highlighting
hi      MyUnwantedChars ctermbg=red   guibg=red
match   MyUnwantedChars /\t\+ \+\| \+\t\+\|\s\+$/

" GUI colors
hi      ColorColumn     ctermbg=233
hi      SignColumn      ctermbg=16
hi      Search          ctermbg=166   ctermfg=white
hi link QuickFixLine    Search
hi      StatusLine      ctermbg=gray  ctermfg=black
hi      Folded          ctermbg=234   ctermfg=darkcyan
hi      LineNr          ctermfg=darkgray
" hi    CursorLine      ctermbg=darkgray
hi      TabLine         ctermfg=black ctermbg=white cterm=NONE
hi      TabLineFill     ctermfg=black ctermbg=white cterm=NONE
hi      TabLineSel      ctermfg=white ctermbg=blue  cterm=NONE

hi      Pmenu           ctermbg=white ctermfg=black

hi      ALEWarningSign  ctermbg=235 ctermfg=gray

" vimdiff colors
hi      DiffAdd          ctermbg=235  ctermfg=108  guibg=#262626 guifg=#87af87 cterm=reverse        gui=reverse
hi      DiffChange       ctermbg=235  ctermfg=103  guibg=#262626 guifg=#8787af cterm=reverse        gui=reverse
hi      DiffDelete       ctermbg=235  ctermfg=131  guibg=#262626 guifg=#af5f5f cterm=reverse        gui=reverse
hi      DiffText         ctermbg=235  ctermfg=208  guibg=#262626 guifg=#ff8700 cterm=reverse        gui=reverse

" GitGutter colors
hi      GitGutterAdd          ctermbg=darkgreen
hi      GitGutterChange       ctermbg=darkblue
hi      GitGutterDelete       ctermbg=brown
hi      GitGutterChangeDelete ctermbg=brown

" markdown colors
hi def link markdownCode                String
hi def link markdownUrl                 Function
hi def link markdownGreedyId            Operator
hi def link markdownHeadingDelimiter    htmlH1

" HTML colors
hi      htmlLink        ctermfg=green

" programming languages syntax colors
hi      Normal          ctermfg=252
hi      Comment         ctermfg=darkgray
    hi  phpDocTags      ctermfg=darkcyan
    hi  phpDocParam     ctermfg=darkgreen
hi      Constant        ctermfg=brown
    hi  String          ctermfg=228
    hi  Character       ctermfg=yellow
    hi  Number          ctermfg=183
    hi  Boolean         ctermfg=105
    hi  Float           ctermfg=magenta
hi      Identifier      ctermfg=gray
    hi  Function        ctermfg=80
hi      Statement       ctermfg=darkcyan
    hi  Conditional     ctermfg=105
    hi  Repeat          ctermfg=darkcyan
    hi  Label           ctermfg=darkcyan
    hi  Operator        ctermfg=darkcyan
    hi  Keyword         ctermfg=darkcyan
    hi  Exception       ctermfg=cyan
hi      PreProc         ctermfg=darkblue
    hi  Include         ctermfg=blue
    hi  Define          ctermfg=blue
    hi  Macro           ctermfg=blue
    hi  PreCondit       ctermfg=blue
hi      Type            ctermfg=green
    hi  StorageClass    ctermfg=darkgreen
    hi  Structure       ctermfg=darkgreen
    hi  Typedef         ctermfg=darkgreen
hi      Special         ctermfg=white
    hi  SpecialChar     ctermfg=red
    hi  Tag             ctermfg=red
    hi  Delimiter       ctermfg=211
    hi  SpecialComment  ctermfg=red
    hi  Debug           ctermfg=red
hi      Ignore          ctermfg=black
hi      Error           ctermbg=red
hi      Todo            ctermbg=darkred ctermfg=white

"augroup DimInactiveWindows
    "autocmd!
    "autocmd WinEnter * hi CursorLine ctermbg=none
    "autocmd WinLeave * hi CursorLine ctermbg=gray
"augroup END
