if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/maestro/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/maestro/.vim/dein')
    call dein#begin('/home/maestro/.vim/dein')

    " Let dein manage dein
    " Required:
    call dein#add('/home/maestro/.vim/dein/repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here:
    " call dein#add('Shougo/neosnippet.vim')
    " call dein#add('Shougo/neosnippet-snippets')

    " You can specify revision/branch/tag.
    " call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

    call dein#add('justinmk/vim-syntax-extra')

    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-fugitive')
    call dein#add('scrooloose/syntastic')
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTree'})

    call dein#add('majutsushi/tagbar', {'on_cmd': 'TagbarToggle'})

    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets', {'depends': ['ultisnips']})

    call dein#add('jiangmiao/auto-pairs')

    call dein#add('scrooloose/nerdcommenter')

    call dein#add('bling/vim-airline')
    call dein#add('godlygeek/tabular', {'on_cmd': 'Tabularize'})
    call dein#add('Valloric/YouCompleteMe', {'on_ft': ['c', 'cpp', 'go', 'rust'], 'build': 'python2 ./install.py --clang-completer --gocode-completer --racer-completer --tern-completer'})

    call dein#add('kien/ctrlp.vim', {'on_cmd': ['CtrlP', 'CtrlPMRUFiles', 'CtrlPCurrWD']})
    call dein#add('mileszs/ack.vim', {'on_cmd': 'Ack'})
    call dein#add('airblade/vim-gitgutter')
    call dein#add('junegunn/goyo.vim', {'on_cmd': 'Goyo'})

    " call dein#add('LucHermitte/lh-vim-lib')
    " call dein#add('LucHermitte/local_vimrc')

    call dein#add('fatih/vim-go', {'on_ft': ['go']})

    call dein#add('rust-lang/rust.vim', {'on_ft': ['rust']})

    call dein#add('gisraptor/vim-lilypond-integrator')

    " These plugins have no plugin/ directory, no need to be lazy
    call dein#add('suan/vim-instant-markdown')
    call dein#add('tpope/vim-markdown')
    " call dein#add('suan/vim-instant-markdown', {'on_ft': ['markdown']})
    " call dein#add('tpope/vim-markdown', {'on_ft': ['markdown']})

    call dein#add('chriskempson/base16-vim')
    call dein#add('dikiaap/minimalist')
    call dein#add('KabbAmine/yowish.vim')

    " Required:
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

function! DeinPluginUpdate()
    call dein#update()
    call dein#build('YouCompleteMe')
endf

command! PluginUpdate call DeinPluginUpdate()
