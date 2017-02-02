# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="maestro"
# duellj

# Safety measuare against fork bombs #HE1 INF1060 H14
# ulimit -u 200

# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias yr='finger 1365@graph.no'
alias safir='mosh oystedal@safir.ifi.uio.no'
alias sfr='safir'
#alias vor='mosh oystedal@vor.ifi.uio.no'
alias vor='mosh oystedal@austur.ifi.uio.no'
alias dalvik='mosh oystedal@dalvik.ping.uio.no'
#alias da='dalvik'
alias i3conf='vim $HOME/.i3/config'
# alias nkeys='loadkeys no-latin1'
alias cr='chromium'

alias nj='ninja'

alias oystedal='ssh-add ~/.ssh/id_oystedal'

export GOPATH="$HOME/go/"
export GOROOT="/lib/go/"

# Z and V plugins
# source "$HOME/scripts/z/z.sh"
# alias v="$HOME/scripts/v/v"
# alias vl="$HOME/scripts/v/v -l"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git cp golang mosh archlinux history sudo vim-interaction themes colorize colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration

alias ls="ls --color=tty -v --group-directories-first"

# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/home/maestro/go/bin:$HOME/bin/:"
# export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/java/bin:/opt/java/db/bin:/opt/java/jre/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/smlnj/bin:/home/maestro/.gem/ruby/2.0.0/bin:/home/maestro/go/bin:$HOME/bin/:"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/maestro/go/bin:$HOME/bin/:"
# export MANPATH="/usr/local/man:$MANPATH"

source "/etc/profile.d/vte.sh"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# ns-3 compilation settings
# export CFLAGS="-g -O0 -m64 -ftest-coverage -fprofile-arcs -D__NS3_COSIM__ -D__KERNEL__ -D__LINSCHED__ -Wall -Wundef -Wstrict-prototypes -Werror-implicit-function-declaration -fno-common -I /home/maestro/android/ns-allinone-3.19/ns-3.19/src/linsched/model/include -I /home/maestro/android/ns-allinone-3.19/ns-3.19/src/linsched/model/arch/x86/include  -include /home/maestro/android/ns-allinone-3.19/ns-3.19/src/linsched/model/include/linux/autoconf.h -include /home/maestro/android/ns-allinone-3.19/ns-3.19/src/linsched/model/linsched/linux_linsched.h -Wno-pointer-sign -Wno-errors -Wno-deprecated"
# export CXXFLAGS="-Wno-deprecated"
