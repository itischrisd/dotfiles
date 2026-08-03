# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
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

if [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}/ssh-agent.socket"
fi
