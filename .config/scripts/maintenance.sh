#!/bin/bash

# Dotfiles Maintenance Script
# Performs routine maintenance tasks for the dotfiles environment

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

BACKUP_RETENTION_DAYS=30
LOG_FILE="$HOME/.config/logs/maintenance-$(date +%Y%m%d).log"

# Create logs directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

echo -e "${BLUE}🔧 Dotfiles Maintenance${NC}"
echo "========================="
log "Starting maintenance routine"

# Update Homebrew and packages
echo -e "\n${BLUE}📦 Updating Homebrew...${NC}"
if command -v brew >/dev/null 2>&1; then
    log "Updating Homebrew"
    brew update
    
    outdated=$(brew outdated --quiet | wc -l | tr -d ' ')
    if [[ $outdated -gt 0 ]]; then
        echo -e "${YELLOW}⚠️  $outdated packages need updating${NC}"
        log "Found $outdated outdated packages"
        brew upgrade
        log "Upgraded packages"
    else
        echo -e "${GREEN}✅ All packages up to date${NC}"
        log "All packages up to date"
    fi
    
    # Clean up old versions
    brew cleanup
    log "Cleaned up Homebrew cache"
else
    echo -e "${RED}❌ Homebrew not found${NC}"
    log "ERROR: Homebrew not found"
fi

# Update shell plugins
echo -e "\n${BLUE}🔌 Updating Shell Plugins...${NC}"
if command -v zinit >/dev/null 2>&1; then
    log "Updating Zinit plugins"
    zinit self-update
    zinit update --all
    log "Updated Zinit and all plugins"
else
    echo -e "${YELLOW}⚠️  Zinit not available in current session${NC}"
    log "WARNING: Zinit not available"
fi

# Update Neovim plugins
echo -e "\n${BLUE}📝 Updating Neovim...${NC}"
if command -v nvim >/dev/null 2>&1; then
    log "Updating Neovim plugins"
    nvim --headless "+Lazy! sync" +qa
    log "Updated Neovim plugins"
else
    echo -e "${RED}❌ Neovim not found${NC}"
    log "ERROR: Neovim not found"
fi

# Update tldr cache
echo -e "\n${BLUE}📚 Updating Documentation...${NC}"
if command -v tldr >/dev/null 2>&1; then
    log "Updating tldr cache"
    tldr --update
    log "Updated tldr cache"
fi

# Clean up old backups
echo -e "\n${BLUE}🧹 Cleaning Up Old Backups...${NC}"
backup_count=$(find "$HOME" -maxdepth 1 -name "dotfiles-backup-*" -type d 2>/dev/null | wc -l | tr -d ' ')
if [[ $backup_count -gt 0 ]]; then
    log "Found $backup_count backup directories"
    old_backups=$(find "$HOME" -maxdepth 1 -name "dotfiles-backup-*" -type d -mtime +$BACKUP_RETENTION_DAYS 2>/dev/null)
    
    if [[ -n "$old_backups" ]]; then
        echo "$old_backups" | while read -r backup; do
            echo -e "${YELLOW}🗑️  Removing old backup: $(basename "$backup")${NC}"
            rm -rf "$backup"
            log "Removed old backup: $backup"
        done
    else
        echo -e "${GREEN}✅ No old backups to clean${NC}"
        log "No old backups found for cleanup"
    fi
else
    echo -e "${GREEN}✅ No backup directories found${NC}"
    log "No backup directories found"
fi

# Clean up shell history duplicates
echo -e "\n${BLUE}📝 Optimizing Shell History...${NC}"
if [[ -f "$HOME/.zsh_history" ]]; then
    original_size=$(wc -l < "$HOME/.zsh_history")
    log "Original history size: $original_size lines"
    
    # Create backup of history
    cp "$HOME/.zsh_history" "$HOME/.zsh_history.backup"
    
    # Remove duplicates while preserving order
    awk '!seen[$0]++' "$HOME/.zsh_history.backup" > "$HOME/.zsh_history"
    
    new_size=$(wc -l < "$HOME/.zsh_history")
    removed=$((original_size - new_size))
    
    if [[ $removed -gt 0 ]]; then
        echo -e "${GREEN}✅ Removed $removed duplicate history entries${NC}"
        log "Removed $removed duplicate history entries"
    else
        echo -e "${GREEN}✅ No duplicate history entries found${NC}"
        log "No duplicate history entries found"
    fi
    
    # Clean up backup
    rm "$HOME/.zsh_history.backup"
fi

# Check for broken symlinks
echo -e "\n${BLUE}🔗 Checking for Broken Links...${NC}"
broken_links=$(find "$HOME/.config" -type l -exec test ! -e {} \; -print 2>/dev/null || true)
if [[ -n "$broken_links" ]]; then
    echo -e "${YELLOW}⚠️  Found broken symlinks:${NC}"
    echo "$broken_links"
    log "Found broken symlinks: $broken_links"
else
    echo -e "${GREEN}✅ No broken symlinks found${NC}"
    log "No broken symlinks found"
fi

# Git repository maintenance
echo -e "\n${BLUE}🗂️  Git Repository Maintenance...${NC}"
if [[ -d "$HOME/code/.dotfiles" ]]; then
    cd "$HOME"
    
    # Check for uncommitted changes
    if ! /usr/bin/git --git-dir="$HOME/code/.dotfiles/" --work-tree="$HOME" diff --quiet; then
        echo -e "${YELLOW}⚠️  Uncommitted changes in dotfiles${NC}"
        log "WARNING: Uncommitted changes in dotfiles"
        /usr/bin/git --git-dir="$HOME/code/.dotfiles/" --work-tree="$HOME" status --short
    else
        echo -e "${GREEN}✅ Dotfiles repository is clean${NC}"
        log "Dotfiles repository is clean"
    fi
    
    # Optimize repository
    log "Running git maintenance"
    /usr/bin/git --git-dir="$HOME/code/.dotfiles/" --work-tree="$HOME" gc --auto
    log "Completed git maintenance"
fi

# Clean up logs older than 30 days
echo -e "\n${BLUE}📋 Cleaning Up Old Logs...${NC}"
if [[ -d "$HOME/.config/logs" ]]; then
    old_logs=$(find "$HOME/.config/logs" -name "maintenance-*.log" -mtime +30 2>/dev/null || true)
    if [[ -n "$old_logs" ]]; then
        echo "$old_logs" | while read -r logfile; do
            echo -e "${YELLOW}🗑️  Removing old log: $(basename "$logfile")${NC}"
            rm -f "$logfile"
        done
        log "Cleaned up old log files"
    else
        echo -e "${GREEN}✅ No old logs to clean${NC}"
        log "No old logs found for cleanup"
    fi
fi

# Performance check
echo -e "\n${BLUE}⚡ Performance Check...${NC}"
startup_time=$(time zsh -i -c exit 2>&1 | grep real | awk '{print $2}' | sed 's/[^0-9.]//g' | head -1)
if [[ -n "$startup_time" ]]; then
    echo -e "${BLUE}Shell startup time: ${startup_time}s${NC}"
    log "Shell startup time: ${startup_time}s"
    
    # Warn if startup time is too slow
    if (( $(echo "$startup_time > 2.0" | bc -l 2>/dev/null || echo "0") )); then
        echo -e "${YELLOW}⚠️  Shell startup is slow (>${startup_time}s). Consider profiling with 'zinit times'${NC}"
        log "WARNING: Slow shell startup time"
    fi
fi

# Generate summary
echo -e "\n${BLUE}📊 Maintenance Summary${NC}"
echo "======================"
echo -e "• ${GREEN}Maintenance completed successfully${NC}"
echo -e "• Log file: ${BLUE}$LOG_FILE${NC}"
echo -e "• Next maintenance recommended: ${YELLOW}$(date -d '+1 week' '+%Y-%m-%d')${NC}"

log "Maintenance routine completed successfully"

echo -e "\n${GREEN}🎉 Maintenance completed!${NC}"
echo -e "💡 Run 'dotfiles-health' to verify everything is working correctly."