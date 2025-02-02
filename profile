echo "Loading .profile"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

[ -f "/home/aj/.ghcup/env" ] && . "/home/aj/.ghcup/env" # ghcup-env