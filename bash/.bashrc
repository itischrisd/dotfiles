#!/bin/bash

case $- in
    *i*) ;;
      *) return;;
esac

HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups

shopt -s histappend
shopt -s checkwinsize
shopt -s globstar

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/dircolors ]; then
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='\n'

case "$TERM" in
xterm*|rxvt*)
    PS1+='\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]'
    ;;
*)
    ;;
esac

PS1+='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]'

if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    PS1+='$(__git_ps1 " \[\033[01;33m\](%s)\[\033[00m\]")'
fi

__prepare_prompt_vars() {
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        EXIT_FLAG=1
    else
        unset EXIT_FLAG
    fi
}
PROMPT_COMMAND=__prepare_prompt_vars

PS1+='${EXIT_FLAG:+\[\033[01;31m\] x\[\033[00m\]}'
PS1+='\n${EXIT_FLAG:+\[\033[01;34m\]}\$\[\033[00m\] '

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\e[1;5C":forward-word'
bind '"\e[1;5D":backward-word'
bind '"\C-h":backward-kill-word'
bind '"\e[3;5~":kill-word'

alias rm='rm -i'
alias ll='ls -hlF'
alias la='ls -ahlF'
alias mkdir='mkdir -p'
alias du.='du --exclude={.,..} -sch * 2>/dev/null | sort -rh'
alias duh.='du --exclude={.,..} -sch .* 2>/dev/null | sort -rh'
alias python='python3'

if type -P nvim &>/dev/null; then
    alias vim=nvim
    alias vi=nvim
elif type -P vim &>/dev/null; then
    alias nvim=vim
    alias vi=vim
elif type -P vi &>/dev/null; then
    alias nvim=vi
    alias vim=vi
fi

command -v batcat &>/dev/null && alias cat='batcat -P'
command -v clear &>/dev/null || alias clear='printf "\033c"'
