function! fileswitch#MapBuffers()
    const KEYS = 10
    const ls = execute("ls")
    const lines = split(ls, "\n")
    const bindcount = min([len(lines), KEYS])

    for i in range(0, bindcount - 1)
        let keynumber = (i + 1) % KEYS
        let key = printf(g:fileswitch_keyformat, keynumber)
        let line = split(lines[i])
        let buffer = line[0]
        execute "nnoremap ". key ." :b ". buffer ."<CR>"
    endfor
endfunction
