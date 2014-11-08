set spell spelllang=en_gb

" Yellow fields
syntax match Statement /^\(Project\|Opened\|UUID\|Description\):/
syntax match Statement /\(Priority\|Closed\):/

" Highlight fields needing editing
syntax match Todo /\<TODO\>/

" Disable spelling on UUID
syntax match NoSpell /\(\x\+-\)\{4}\x\+/ contains=@NoSpell

fun! CompleteField(findstart, base)
  let line = getline('.')
  let col = col('.')

  if a:findstart
    " locate the start of the word
    let start = col - 1
    while start > 0 && line[start - 1] =~ '\S'
      let start -= 1
    endwhile
    return start
  else
    " find field values matching "a:base"
    let res = []
    let today = strftime('%Y/%m/%d')

    if line[:col] =~ 'Priority:'
      for m in [today] + split(system('tasks priorities'))
        if m =~ '^' . a:base
          call add(res, m)
        endif
      endfor
    elseif line[:col] =~ '^Project:'
      for m in split(system('tasks projects'))
        if m =~ '^' . a:base
          call add(res, m)
        endif
      endfor
    elseif line[:col] =~ 'Closed:'
      if today =~ '^' . a:base
        call add(res, today)
      endif
    endif

    return res
  endif
endfun

set completefunc=CompleteField
