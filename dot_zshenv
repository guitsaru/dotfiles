# Sourced by EVERY zsh, including non-interactive and non-login shells
# (`zsh -c ...`, scripts, editor subprocesses). This is the only startup
# file that runs in those contexts, so mise's shims belong here.
#
# Interactive shells additionally run `mise activate` from .zshrc, which
# prepends the real tool paths ahead of these shims. Both mechanisms
# coexist: activate wins interactively, shims cover everything else.

# Keep PATH free of duplicates, keeping the leftmost (highest priority)
# occurrence. This lets .zprofile safely re-prepend without stacking up
# repeated entries.
typeset -U path PATH

export PATH="$HOME/.local/share/mise/shims:$PATH"
