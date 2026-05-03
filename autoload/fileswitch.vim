function! s:BufferIsFile(buffernumber)
    return getbufvar(a:buffernumber, '&buftype') == ''
endfunction

function! s:LsToFileLines()
    const ls = execute("ls")
    const lines = split(ls, "\n")
    const linecount = len(lines)

    let filelines = []
    for i in range(0, linecount - 1)
        let line = split(lines[i])
        let buffernumber = str2nr(line[0])
        if s:BufferIsFile(buffernumber)
            call add(filelines, lines[i])
        endif
    endfor
    return filelines
endfunction

function! s:FindCharIndex(string, char, startindex)
    let length = len(a:string)
    for i in range(a:startindex, length - 1)
        if a:string[i] == a:char
            return i
        endif
    endfor
    return -1
endfunction

function! s:FileLinesToEcho()
    let filelines = s:LsToFileLines()
    let linecount = len(filelines)
    for i in range(0, linecount - 1)
        let line = filelines[i]
        let startquoteindex = s:FindCharIndex(line, '"', 0)
        if (startquoteindex < 0)
            continue
        endif
        let endquoteindex = s:FindCharIndex(line, '"', startquoteindex + 1)
        if (endquoteindex < 0)
            continue
        endif
        let filepath = line[startquoteindex:endquoteindex]
        let filelines[i] = string(i + 1) . ' ' . filepath
    endfor
    return filelines
endfunction

function! fileswitch#SetStatusLine()
    let filelines = s:FileLinesToEcho()
    let linecount = len(filelines)

    execute 'set statusline='
    for i in range(0, linecount - 1)
        let line = filelines[i]

        let splitline = split(line, ' "')
        let keynumber = splitline[0]
        let filepath = splitline[1]
        let pathwithoutquotes = split(filepath, '"')[0]
        let splitpath = split(pathwithoutquotes, '\')
        let filename = splitpath[len(splitpath) - 1]

        execute 'set statusline+=' . keynumber . '\ ' . join(split(filename), '\ ')
        let delimiter = (i != linecount - 1) ? '\ \|\ ' : ''
        execute 'set statusline+=' . delimiter
    endfor
endfunction

function! s:LsToFileNumbers()
    const ls = execute("ls")
    const lines = split(ls, "\n")
    const linecount = len(lines)

    let filenumbers = []
    for i in range(0, linecount - 1)
        let line = split(lines[i])
        let buffernumber = str2nr(line[0])
        if s:BufferIsFile(buffernumber)
            call add(filenumbers, buffernumber)
        endif
    endfor
    return filenumbers
endfunction

function! fileswitch#BindKeysToFiles()
    const KEYS = 10
    const filenumbers = s:LsToFileNumbers()
    const bindcount = min([len(filenumbers), KEYS])

    for i in range(0, bindcount - 1)
        let keynumber = (i + 1) % KEYS
        let key = printf(g:fileswitch_keyformat, keynumber)
        let filenumber = filenumbers[i]
        execute "nnoremap ". key ." :b ". filenumber ."<CR>"
    endfor
endfunction
