#! /usr/bin/bash

DOTFILES="$HOME/.files"
BACKUPDIR="$DOTFILES/backup"


function backup_and_install {
    # $1: Source file
    # $2: Target path
    # #3: Backup name

    # if target exists and is not a symbolic link
    if [ -e $2 ] && ! [ -L $2 ]; then
        bname=`date +%FT%T`_$3
        mkdir -p $BACKUPDIR
        mv $2 "$BACKUPDIR/$bname" &&
            echo "$2 backed up to $bname" &&
            ln -s "$1" $2 &&
            echo "Linked $2"
    elif [ -L $2 ]; then
        # echo "$2 is already linked"
        : # Noop
    else
        ln -s "$DOTFILES/$1" $2
    fi

    if [ $? -ne 0 ]; then
        echo "Failed to link $2"
    fi
}

# zsh
backup_and_install "zshrc" "$HOME/.zshrc" "zshrc"
backup_and_install "maestro.zsh-theme" "$HOME/.oh-my-zsh/themes/maestro.zsh-theme" "maestro.zsh-theme"

# vim
backup_and_install "vim/global.vim" "$HOME/.vim/global.vim" "global.vim"
backup_and_install "vim/dein-plugins.vim" "$HOME/.vim/dein-plugins.vim" "dein-plugins.vim"

# i3
backup_and_install "i3config" "$HOME/.i3/config" "i3config"

# TODO: termite
