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

" https://vi.stackexchange.com/a/37661
function! fileswitch#EchoFileLines()
    let filelines = s:LsToFileLines()
    let linecount = len(filelines)
    for i in range(0, linecount - 1)
        let line = split(filelines[i])
        let line[0] = string(i + 1)
        let filelines[i] = join(line, ' ')
    endfor
    for line in filelines
        echom line
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
