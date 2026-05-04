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
    autocmd BufAdd,BufDelete * call timer_start(0, { -> fileswitch#SetStatusLine() })
augroup END

if !exists("g:fileswitch_use_defaults") || g:fileswitch_use_defaults
    set laststatus=2
endif
