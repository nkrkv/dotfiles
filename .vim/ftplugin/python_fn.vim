" Python file type plugin
"
" Based on original work by:
"     Mikael Berthe <bmikael@lists.lilotux.net>
"     Maintained by Jon Franklin <jvfranklin@gmail.com>

" Only do this when not done yet for this buffer
if exists("b:loaded_py_ftplugin")
  finish
endif
let b:loaded_py_ftplugin = 1

vmap ac   :<C-U>call PythonSelectObject("class")<CR>
vmap af   :<C-U>call PythonSelectObject("function")<CR>

omap ac   :normal Vac<CR>
omap af   :normal Vaf<CR>

map  <silent> [g   :call PythonNextLine(-1)<CR>
map  <silent> ]g   :call PythonNextLine(1)<CR>

" jump to previous class
map  <silent> [c   :call PythonDec("class", -1)<CR>
vmap <silent> [c   :call PythonDec("class", -1)<CR>

" jump to next class
map  <silent> ]c   :call PythonDec("class", 1)<CR>
vmap <silent> ]c   :call PythonDec("class", 1)<CR>

" jump to previous function
map  <silent> [f   :call PythonDec("function", -1)<CR>
vmap <silent> [f   :call PythonDec("function", -1)<CR>

" jump to next function
map  <silent> ]f   :call PythonDec("function", 1)<CR>
vmap <silent> ]f   :call PythonDec("function", 1)<CR>


:com! PBoB execute "normal ".PythonBoB(line('.'), -1, 1)."G"
:com! PEoB execute "normal ".PythonBoB(line('.'), 1, 1)."G"


" Go to a block boundary (-1: previous, 1: next)
" If force_sel_comments is true, 'g:py_select_trailing_comments' is ignored
function! PythonBoB(line, direction, force_sel_comments)
  let ln = a:line
  let ind = indent(ln)
  let mark = ln
  let indent_valid = strlen(getline(ln))
  let ln = ln + a:direction
  if (a:direction == 1) && (!a:force_sel_comments) && 
      \ exists("g:py_select_trailing_comments") && 
      \ (!g:py_select_trailing_comments)
    let sel_comments = 0
  else
    let sel_comments = 1
  endif

  while((ln >= 1) && (ln <= line('$')))
    if  (sel_comments) || (match(getline(ln), "^\\s*#") == -1)
      if (!indent_valid)
        let indent_valid = strlen(getline(ln))
        let ind = indent(ln)
        let mark = ln
      else
        if (strlen(getline(ln)))
          if (indent(ln) < ind)
            break
          endif
          let mark = ln
        endif
      endif
    endif
    let ln = ln + a:direction
  endwhile

  return mark
endfunction


" Go to previous (-1) or next (1) class/function definition
function! PythonDec(obj, direction)
  if (a:obj == "class")
    let objregexp = "^\\s*class\\s\\+[a-zA-Z0-9_]\\+"
        \ . "\\s*\\((\\([a-zA-Z0-9_,. \\t\\n]\\)*)\\)\\=\\s*:"
  else
    let objregexp = "^\\s*def\\s\\+[a-zA-Z0-9_]\\+\\s*(\\_[^:#]*)\\s*:"
  endif
  let flag = "W"
  if (a:direction == -1)
    let flag = flag."b"
  endif
  let res = search(objregexp, flag)
endfunction


" Select an object ("class"/"function")
function! PythonSelectObject(obj)
  " Go to the object declaration
  normal $
  call PythonDec(a:obj, -1)
  let declLine = line('.')
  let beg = declLine
  let selLeadingComments = !exists("g:py_select_leading_comments") || (g:py_select_leading_comments)

  let decind = indent(beg)
  let cl = beg
  while (cl>1)
    let cl = cl - 1
    if indent(cl) != decind
      break
    endif
    let firstSymbol = getline(cl)[decind]
    if firstSymbol == '@' || (firstSymbol == '#' && selLeadingComments)
      let beg = cl
    else
      break
    endif
  endwhile

  " Move to the colon finishing our declaration
  execute ":".declLine
  execute "normal %f:"

  " Is it a one-line definition?
  if match(getline('.'), "^\\s*\\(#.*\\)\\=$", col('.')) == -1
    let cl = line('.')
    execute ":".beg
    execute "normal V".cl."G"
  else
    " Select the whole block
    let cl = line('.') + 1
    execute ":".beg
    execute "normal V".PythonBoB(cl, 1, 0)."G"
  endif
endfunction


" Jump to the next line with the same (or lower) indentation
" Useful for moving between "if" and "else", for example.
function! PythonNextLine(direction)
  let ln = line('.')
  let ind = indent(ln)
  let indent_valid = strlen(getline(ln))
  let ln = ln + a:direction

  while((ln >= 1) && (ln <= line('$')))
    if (!indent_valid) && strlen(getline(ln)) 
        break
    else
      if (strlen(getline(ln)))
        if (indent(ln) <= ind)
          break
        endif
      endif
    endif
    let ln = ln + a:direction
  endwhile

  execute "normal ".ln."G"
endfunction

" vim:set et sts=2 sw=2:
