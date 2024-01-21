function! MyWikiResolver(url) abort
  let l:url = deepcopy(a:url)

  let l:url.anchor = wiki#url#utils#extract_anchor(l:url.stripped)

  let l:filename = split(l:url.stripped, '#', 1)[0]
  if empty(l:filename)
    let l:url.path = l:url.origin
  else
    let l:pattern = printf('%s/**/%s.*',
          \ wiki#get_root(),
          \ l:filename)
    let l:paths = glob(l:pattern, v:true, v:true)
    let l:path = wiki#ui#select(l:paths)

    let l:url.path = wiki#url#utils#add_extension(wiki#paths#s(l:path))
  endif

  return l:url
endfunction

let g:wiki_link_creation = {
    \ 'md': {
    \   'link_type': 'wiki',
    \   'url_extension': '',
    \ }
    \}

let g:wiki_link_schemes = {
    \ 'wiki': {
    \   'resolver': function('MyWikiResolver'),
    \ }
    \}
