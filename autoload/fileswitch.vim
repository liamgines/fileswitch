function! s:BufferIsFile(buffernumber)
    return getbufvar(a:buffernumber, '&buftype') == ''
endfunction

function! s:LsToFileLines()
    const ls = execute("ls")
    const lines = split(ls, "\n")

    let filelines = []
    for i in range(0, len(lines) - 1)
        let line = split(lines[i])
        let buffer = line[0]
        let buffernumber = str2nr(buffer)
        if s:BufferIsFile(buffernumber)
            call add(filelines, lines[i])
        endif
    endfor
    return filelines
endfunction

function! fileswitch#BindKeysToFiles()
    const KEYS = 10
    const lines = s:LsToFileLines()
    const bindcount = min([len(lines), KEYS])

    for i in range(0, bindcount - 1)
        let keynumber = (i + 1) % KEYS
        let key = printf(g:fileswitch_keyformat, keynumber)
        let line = split(lines[i])
        let buffer = line[0]
        execute "nnoremap ". key ." :b ". buffer ."<CR>"
    endfor
endfunction
