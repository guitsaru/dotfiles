# ---- History -------------------------------------------------------------
# macOS /etc/zshrc caps SAVEHIST at 1000; override it here.
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY       # record timestamp + duration
setopt INC_APPEND_HISTORY     # write immediately, not at shell exit
setopt SHARE_HISTORY          # share between concurrent shells
setopt HIST_IGNORE_ALL_DUPS   # drop older duplicates
setopt HIST_IGNORE_SPACE      # leading space = don't record
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY            # expand !! for confirmation instead of running
setopt HIST_FCNTL_LOCK

# ---- PATH ----------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# ---- Completions ---------------------------------------------------------
# Homebrew's completion functions, when Homebrew is present. $HOMEBREW_PREFIX
# is exported by `brew shellenv` in .zprofile; on Linux there is no Homebrew
# and the distro's own site-functions are already on FPATH.
[[ -n "$HOMEBREW_PREFIX" && -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]] \
  && FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"

autoload -Uz compinit
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
# Full rebuild at most once a day; cheap -C load otherwise.
if [[ ! -e "$_zcompdump" ]] || [[ -n "$(find "$_zcompdump" -mtime +1 2>/dev/null)" ]]; then
  compinit -d "$_zcompdump"
else
  compinit -C -d "$_zcompdump"
fi
unset _zcompdump

# `menu no` is required by fzf-tab: it stops zsh drawing its own menu so
# fzf-tab can capture the unambiguous prefix itself.
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Keep git's own ordering for branches instead of sorting alphabetically.
zstyle ':completion:*:git-checkout:*' sort false

# fzf-tab must load after compinit and before any plugin that wraps
# widgets (zsh-autosuggestions, below).
source "$HOME/.local/share/zsh/fzf-tab/fzf-tab.zsh"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --group-directories-first $realpath'
zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --color=always --group-directories-first $realpath'

# ---- Tools ---------------------------------------------------------------
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# fzf: Ctrl-R history search, Ctrl-T file picker, Alt-C cd, ** completion
eval "$(fzf --zsh)"

# zoxide: `z <partial>` jumps to a frecent dir, `zi` picks interactively.
eval "$(zoxide init zsh)"

# ---- Aliases -------------------------------------------------------------
alias ls='eza --group-directories-first'
alias ll='eza -l --git --group-directories-first'
alias la='eza -la --git --group-directories-first'
alias lt='eza --tree --level=2 --group-directories-first'

# bat prints plain when piped, so this stays safe in pipelines.
alias cat='bat --paging=never'
export PAGER=less
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# ---- Autosuggestions -----------------------------------------------------
# Ghosted suggestion from history as you type; accept with the right arrow
# key or End. Must be sourced after compinit for the completion strategy.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Only rebind widgets once at startup rather than on every keypress.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# Don't try to suggest for enormous pastes.
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
source "$HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Accept the whole suggestion with Ctrl-Space, one word with Alt-Right.
bindkey '^ ' autosuggest-accept
