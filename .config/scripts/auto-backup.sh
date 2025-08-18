#!/bin/bash

# Automated Backup Script for Dotfiles
# Runs weekly via cron to create automatic backups

set -e

BACKUP_DIR="$HOME/dotfiles-backups"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
BACKUP_PATH="$BACKUP_DIR/auto-backup-$TIMESTAMP"
LOG_FILE="$HOME/.config/logs/auto-backup.log"
MAX_BACKUPS=4  # Keep 4 weeks of backups

# Create directories
mkdir -p "$BACKUP_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

log "Starting automated backup"

# Create backup directory
mkdir -p "$BACKUP_PATH"

# Backup critical configurations
configs=(
    ".zshrc"
    ".gitconfig" 
    ".p10k.zsh"
    ".config/zellij"
    ".config/nvim"
    ".config/tmux"
    ".config/ghostty"
    ".config/scripts"
    "code/dotfiles"
)

for config in "${configs[@]}"; do
    source_path="$HOME/$config"
    if [[ -e "$source_path" ]]; then
        cp -r "$source_path" "$BACKUP_PATH/" 2>/dev/null || true
        log "Backed up: $config"
    fi
done

# Create backup metadata
cat > "$BACKUP_PATH/backup-info.txt" << EOF
Backup Created: $(date)
System: $(uname -a)
Shell: $SHELL
Backup Type: Automated Weekly
EOF

log "Backup created: $BACKUP_PATH"

# Clean up old backups
old_backups=$(find "$BACKUP_DIR" -name "auto-backup-*" -type d | sort | head -n -$MAX_BACKUPS)
if [[ -n "$old_backups" ]]; then
    echo "$old_backups" | while read -r old_backup; do
        rm -rf "$old_backup"
        log "Removed old backup: $(basename "$old_backup")"
    done
fi

# Compress backup to save space
tar -czf "$BACKUP_PATH.tar.gz" -C "$BACKUP_DIR" "$(basename "$BACKUP_PATH")"
rm -rf "$BACKUP_PATH"
log "Compressed backup: $BACKUP_PATH.tar.gz"

log "Automated backup completed successfully"

# Optional: Send notification (requires terminal-notifier on macOS)
if command -v terminal-notifier >/dev/null 2>&1; then
    terminal-notifier -title "Dotfiles Backup" -message "Weekly backup completed successfully" >/dev/null 2>&1 || true
fi