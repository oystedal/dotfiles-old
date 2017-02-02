" source ~/.vim/vundle-plugins.vim
" source ~/.vim/plug-plugins.vim
source ~/.vim/dein-plugins.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Sanity section                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible          " vi is archaic
syntax on                 " syntax highlighting
filetype plugin indent on " filetype plugins and filetype indentation
set encoding=utf-8        " Proper encoding

" backup to ~/.tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

set splitright " New splits open to the right (:bel vsp)

set nojoinspaces " No double space bs

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Style section                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" UI style options
" colorscheme desert
" set guifont=Inconsolata\ 13

" GUI style options
" Essentially remove everything
set guioptions-=r
set guioptions-=L
set guioptions-=t
set guioptions-=m
set guioptions-=T

set guicursor+=a:blinkon0 " Blinking is the enemy

" Status line definition
if exists("*fugitive#head")
    set statusline=%<:b\ %n\ %f:%Y\ [%{fugitive#head()}]%<%{FileTime()}%<\ %m%=%-1.(%l/%L%)%=%{CurTime()}\ 
else
    " TODO: Fugitive-less statusline
endif
set laststatus=2

" colorcolumn and line numbers
set colorcolumn=80
set number
set numberwidth=5

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Indentation                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Default indent settings
" set cindent
set expandtab
set tabstop=4
set shiftwidth=4
set nowrap

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Utility mappings                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" type jj to enter normal mode
inoremap jj <ESC>

" Moving lines up and down
nnoremap <C-S-j> :m+<CR>==
nnoremap <C-S-k> :m-2<CR>==
vnoremap <C-S-j> :m'>+<CR>gv=gv
vnoremap <C-S-k> :m-2<CR>gv=gv
"inoremap <C-S-j> <ESC>:m+<CR>==gi
"inoremap <C-S-k> <ESC>:m-2<CR>==gi

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Leader section                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "," " use , as leader

" refresh ctags
nmap <Leader>x :execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."<CR>

" toggle fullscreen with Goyo
nmap <Leader>f :Goyo<CR>

" open ctrlp
nmap <Leader>m :CtrlPMRUFiles<CR>
nmap <Leader>o :CtrlPCurWD<CR>

" diff mappings
vmap <Leader>dp :diffput<CR>:diffupdate<CR>
vmap <Leader>dg :diffget<CR>:diffupdate<CR>
vmap <Leader>du :diffupdate<CR>

" vimrc et al. mappings
nmap <Leader>re :execute "edit " . $MYVIMRC<CR>
nmap <Leader>rs :execute "source " . $MYVIMRC<CR>
nmap <Leader>rg :execute "edit " . $HOME . "/.vim/global.vim"<CR>
nmap <Leader>rp :execute "edit " . $HOME . "/.vim/plugins.vim"<CR>

" nmap <Leader>n :bn<CR>
" nmap <Leader>b :bp<CR>
" nnoremap <Leader>t :call ToggleAutoWrap()<CR>

"imap <Leader>o // OYSTEDAL
"nmap <Leader>hn :GitGutterNextHunk<CR>
"nmap <Leader>y "+y
"vmap <Leader>y "+y

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            Commands & Functions                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Convenient folding shortcut
function! g:FoldWithSpace()
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
    vnoremap <Space> zf
endf

" stackoverflow.com/questions/15407652/
" How can i run git diff staged with fugitive?
command! Greview :Git! diff --staged
nnoremap <leader>gr :Greview<CR>

function! Trailing_whitespace()
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
endfunction

function! ListLeaders()
     silent! redir @a
     silent! nmap <LEADER>
     silent! redir END
     silent! new
     silent! put! a
     silent! g/^s*$/d
     silent! %s/^.*,//
     silent! normal ggVg
     silent! sort
     silent! let lines = getline(1,"$")
endfunction

function! ToggleAutoWrap()
    let l:fowrap = stridx(&formatoptions, "a")
    if l:fowrap > 0
        set formatoptions-=a
        echo "Wrapping off"
    else
        set formatoptions+=a
        echo "Wrapping on"
    endif
endfunction

" Utility functions for increasing/decreasing font sizes
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 32
function! AdjustFontSize(amount)
  if has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
      set columns=9999
      set lines=999
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Other                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntastic settings
let g:syntastic_python_checkers=['pylint']

" No folding of comments in C
let c_no_comment_fold=1

" Auto-pairs options
let g:AutoPairsShortcutFastWrap='<Nop>'

" NERDTree options
let g:NERDTreeWinSize=30
let g:NERDTreeChDirMode=2

" CtrlP settings
let g:ctrlp_cmd = 'CtrlPBuffer'
nmap <C-f> :CtrlP<CR>

" Goyo settings
let g:goyo_width=100

" vim-go(?)
highlight! goCoverageNormalText gui=NONE
highlight! goCoverageUncover gui=undercurl guisp=red
highlight! goCoverageCovered gui=undercurl guisp=green

" ifdef highlight
hi link ifdefIfZero Comment
hi link ifdefUndefined Comment
hi link ifdefNeutralDefine PreCondit            
hi link ifdefInBadPreCondit PreCondit           
hi link ifdefInUndefinedComment ifdefUndefined  
hi link ifdefPreCondit1 PreCondit               
hi link ifdefElseEndifInBracketError Special    

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Old stuff                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tag List options
" let g:Tlist_Use_Right_Window=1

" DelimitMate options
" let g:delimitMate_expand_cr=1

" Use nosetest(2) as compiler, so that we can use make to run tests
" autocmd BufNewFile,BufRead *.py compiler nose
" let g:makegreen_stay_on_file = 1

" let g:Tex_ViewRule_pdf='evince'

" autocmd BufNewFile,BufRead *.maude set ft=maude
" autocmd BufNewFile,BufRead *.cup set ft=cup
" autocmd BufNewFile,BufRead *.tex set ft=tex

" The current file time
" function! FileTime()
"   let ext=tolower(expand("%:e"))
"   let fname=tolower(expand('%<'))
"   let filename=fname . '.' . ext
"   let msg=" "
"   let msg=msg." ".strftime("(%d. %b %y %H:%M)",getftime(filename))
"   return msg
" endfunction

" The current system time, displayed to the right
" function! CurTime()
"   let ftime=""
"   let ftime=ftime." ".strftime("%d. %b %y %H:%M")
"   return ftime
" endfunction

" Template loading
" function! LoadTemplate()
"     silent! 0r ~/.vim/templates/template.%:e
" endfunction
" autocmd! BufNewFile * call LoadTemplate()