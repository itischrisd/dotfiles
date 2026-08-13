#!/bin/bash

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	   . "$HOME/.bashrc"
    fi
fi

case ":$PATH:" in
    *":$HOME/bin:"*) ;;
    *)
        if [ -d "$HOME/bin" ]; then
            PATH="$HOME/bin:$PATH"
        fi
        ;;
esac

case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *)
        if [ -d "$HOME/.local/bin" ]; then
            PATH="$HOME/.local/bin:$PATH"
        fi
        ;;
esac

if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
fi

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if type -P nvim &>/dev/null; then
    export EDITOR=nvim
elif type -P vim &>/dev/null; then
    export EDITOR=vim
elif type -P vi &>/dev/null; then
    export EDITOR=vi
fi

if command -v sublime_text &>/dev/null; then
    export VISUAL=sublime_text
else
    export VISUAL="$EDITOR"
fi

if command -v less &>/dev/null; then
    export PAGER=less
    export LESS="--ignore-case --LONG-PROMPT --squeeze-blank-lines --HILITE-UNREAD --search-skip-screen --RAW-CONTROL-CHARS"
elif command -v more &>/dev/null; then
    export PAGER=more
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"
fi
