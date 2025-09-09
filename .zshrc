# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -f "/opt/homebrew/bin/mise" ]] then
  eval "$(/opt/homebrew/bin/mise activate zsh)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins (using turbo mode for better startup performance)
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-completions

zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# Load vi-mode immediately for better UX
zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# History (optimized for memory and performance)
HISTSIZE=50000
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Editor
export EDITOR=/opt/homebrew/bin/nvim
export VISUAL=/opt/homebrew/bin/nvim

# Aliases
alias ls='eza'
alias cat='bat'
alias vim='nvim'
alias c='clear'
alias dotfiles='/usr/bin/git --git-dir=$HOME/code/.dotfiles/ --work-tree=$HOME'
alias zel='zellij -l welcome'

# Dotfiles management functions
dotfiles-update() {
    echo "🔄 Updating dotfiles..."
    dotfiles add -A
    dotfiles commit -m "Update configurations $(date '+%Y-%m-%d %H:%M')"
    dotfiles push
    echo "✅ Dotfiles updated successfully"
}

dotfiles-backup() {
    echo "💾 Creating backup of current configurations..."
    local backup_dir="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_dir"
    
    # Backup key configurations
    cp ~/.zshrc "$backup_dir/" 2>/dev/null || true
    cp ~/.gitconfig "$backup_dir/" 2>/dev/null || true
    cp ~/.p10k.zsh "$backup_dir/" 2>/dev/null || true
    cp -r ~/.config/zellij "$backup_dir/" 2>/dev/null || true
    cp -r ~/.config/nvim "$backup_dir/" 2>/dev/null || true
    cp -r ~/.config/tmux "$backup_dir/" 2>/dev/null || true
    cp -r ~/.config/ghostty "$backup_dir/" 2>/dev/null || true
    
    echo "✅ Backup created at: $backup_dir"
}

dotfiles-health() {
    echo "🏥 Checking dotfiles health..."
    
    # Check if dotfiles repo is clean
    if dotfiles diff --quiet; then
        echo "✅ Dotfiles repository is clean"
    else
        echo "⚠️  Uncommitted changes in dotfiles:"
        dotfiles status --short
    fi
    
    # Check if tools are installed
    local tools=("nvim" "tmux" "zellij" "lazygit" "fzf" "eza" "bat" "rg" "fd")
    for tool in $tools; do
        if command -v $tool >/dev/null 2>&1; then
            echo "✅ $tool is installed"
        else
            echo "❌ $tool is missing"
        fi
    done
}

# Project management functions
project() {
    local project_dir="$HOME/code/$1"
    if [[ -d "$project_dir" ]]; then
        cd "$project_dir"
        if [[ -f "mix.exs" ]]; then
            zellij -l elixir
        elif [[ -f "Gemfile" ]] && grep -q "rails" Gemfile 2>/dev/null; then
            zellij -l rails
        elif [[ -f "README.md" ]] || [[ -f "docs" ]]; then
            zellij -l docs
        else
            zellij -l general
        fi
    else
        echo "❌ Project '$1' not found in $HOME/code/"
        echo "Available projects:"
        ls -1 "$HOME/code/" 2>/dev/null | head -10
    fi
}

# Quick project listing
projects() {
    echo "📁 Available projects in $HOME/code/:"
    if [[ -d "$HOME/code" ]]; then
        eza -1 "$HOME/code/" | head -20
    else
        echo "No code directory found"
    fi
}

# Git workflow helpers
git-new() {
    if [[ -z "$1" ]]; then
        echo "Usage: git-new <branch-name>"
        return 1
    fi
    git checkout -b "$1"
    git push -u origin "$1"
}

git-clean() {
    echo "🧹 Cleaning up merged branches..."
    git branch --merged | grep -v '\*\|main\|master' | xargs -n 1 git branch -d
    echo "✅ Local cleanup complete"
}

# Shell integrations
eval "$(fzf --zsh)"
if [[ "$CLAUDECODE" != "1" ]]; then
  eval "$(zoxide init --cmd cd zsh)"
fi

# Initialize direnv if available
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# Add script aliases for maintenance
alias setup-validate="$HOME/.config/scripts/setup-validate.sh"
alias maintenance="$HOME/.config/scripts/maintenance.sh"

# Enhanced backup function with automated scheduling
dotfiles-auto-backup() {
    local cron_job="0 2 * * 0 $HOME/.config/scripts/auto-backup.sh"
    
    if crontab -l 2>/dev/null | grep -q "auto-backup.sh"; then
        echo "✅ Auto-backup already scheduled"
    else
        echo "📅 Setting up weekly auto-backup..."
        (crontab -l 2>/dev/null; echo "$cron_job") | crontab -
        echo "✅ Weekly backup scheduled for Sundays at 2 AM"
    fi
}
eval "$(/opt/homebrew/bin/mise activate zsh)"
eval "$(atuin init zsh)"
