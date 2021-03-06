set spell spelllang=en_gb
set clipboard=unnamed
set foldmethod=marker
set filetype=
set nowrap
set foldopen-=search
set noswapfile
set iskeyword+=-

" Comments
syntax match Comment /^#.*/

" Yellow fields
syntax match Statement /^\(Project\|Opened\|UUID\|Description\):/
syntax match Statement /\(Priority\|Closed\):/

" Highlight fields needing editing
syntax match Todo /\<TODO\>/

" Disable spelling on UUID
syntax match NoSpell /\(\x\+-\)\{4}\x\+/ contains=@NoSpell

" Disable spell checking on some patterns
syntax match Technical /\<\(\S\+\)\?\(\d\|[_./~]\)\+\(\S\+\)\?\>/ contains=@NoSpell

" Folds
set foldlevel=1
syntax region taskFold start="^Project: " end="^--\n\n" transparent fold
syntax sync fromstart
set foldmethod=syntax

set foldtext=TaskFoldText()
function TaskFoldText()
  let lines = getline(v:foldstart, v:foldstart+4)
  let prio = matchstr(lines[0], "Priority: .*$")[10:]
  let desc = lines[4][:65]

  return desc . repeat('-', 70 - strlen(desc)) . prio
endfunction

com AddTask call AddTask()

fun! AddTask()
  call search('^--')
  call append(line('.'), [''] + split(system('tasks add'), '\n') + ['--'])
endfun

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
      " get filter if any
      let filter = getline(1)
      if filter[0] == '#'
        let cmd = 'tasks priorities -p' . filter[2:]
      else
        let cmd = 'tasks priorities'
      endif

      " move priorities and description into structure
      let priorities = []
      for line in split(system(cmd), '\n')
        let split = split(line)
        call add(priorities, {'word': split[0], 'info': join(split[1:], ' ')})
      endfor

      " complete
      for m in [{'word': today, 'info': 'Today'}] + priorities
        if m['word'] =~ '^' . a:base
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
    else
        call add(res, today)
        call add(res, strftime('%H:%M'))
    endif

    return res
  endif
endfun

set completefunc=CompleteField
