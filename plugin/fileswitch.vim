if exists("g:loaded_fileswitch")
    finish
endif
let g:loaded_fileswitch = 1

if !exists("g:fileswitch_keyformat")
    let g:fileswitch_keyformat = "<A-%s>"
endif

augroup bufferupdates
    autocmd!
    autocmd BufAdd,BufDelete * call timer_start(0, { -> fileswitch#BindKeysToFiles() })
augroup END
