" author: Espen Angell Kristiansen <post@espenak.net>

function! FoldWithSpace()
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
    vnoremap <Space> zf
endf
