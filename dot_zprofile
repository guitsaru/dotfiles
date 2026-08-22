eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# macOS runs path_helper from /etc/zprofile, which rebuilds PATH and pushes
# anything set in .zshenv behind /usr/bin. Re-prepend the shims so mise's
# tools still win over system binaries of the same name (gem, erb, bundle).
# `typeset -U path` in .zshenv collapses the resulting duplicate.
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Load SSH keys from the macOS keychain once per login, not per shell.
ssh-add --apple-load-keychain -q 2>/dev/null

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
