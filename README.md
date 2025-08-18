# Dotfiles

Personal dotfiles managed using a bare Git repository approach.

## Quick Setup

### Initial Installation

```sh
git clone --bare https://github.com/guitsaru/dotfiles.git $HOME/code/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/code/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

### Post-Checkout Setup

After checking out the dotfiles, run these commands to complete the setup:

```sh
# Install packages and tools
brew bundle

# Reload shell configuration to enable all functions
source ~/.zshrc

# Verify everything is working
dotfiles-health

# Optional: Set up automated backups (runs weekly on Sundays at 2 AM)
dotfiles-auto-backup
```

## Features

- **Modern Shell**: Zsh with Zinit plugin manager and Powerlevel10k prompt
- **Performance Optimized**: Turbo mode loading for faster shell startup
- **Development Tools**: Neovim (LazyVim), Tmux, Zellij with custom layouts
- **Terminal**: Ghostty with Catppuccin theme and JetBrains Mono Nerd Font
- **Git Integration**: Enhanced diff viewing with Delta, useful aliases
- **Project Management**: Smart project detection and layout switching

## Management Commands

Once installed, use these commands to manage your dotfiles:

### Dotfiles Management
```sh
dotfiles-update    # Add, commit, and push all changes
dotfiles-backup    # Create timestamped backup of configurations
dotfiles-health    # Check system health and missing tools
```

### Project Management
```sh
project <name>     # Switch to project with smart layout detection
projects           # List available projects
```

### Git Workflow
```sh
git-new <branch>   # Create and push new branch
git-clean          # Remove merged branches
git recent         # Show recent branches
git cleanup        # Remove merged branches (alias)
```

## Layouts

Zellij automatically detects project types and loads appropriate layouts:

- **Elixir/Phoenix**: `mix.exs` detected → `elixir.kdl`
- **Ruby/Rails**: `Gemfile` with rails → `rails.kdl`  
- **Documentation**: `README.md` or `docs/` → `docs.kdl`
- **General**: Default fallback → `general.kdl`

## Troubleshooting

### Post-Setup Issues

**Functions not available after checkout:**
```sh
# Reload shell configuration
source ~/.zshrc

# Or start a new terminal session
exec zsh
```

**Conflicts during dotfiles checkout:**
```sh
# If you get "untracked working tree files would be overwritten"
# Backup the conflicting files first
mkdir ~/dotfiles-backup-conflicts
mv ~/.config/conflicting-file ~/dotfiles-backup-conflicts/

# Then retry checkout
dotfiles checkout
```

### Shell Issues

**Slow startup time:**
```sh
# Profile zsh startup
time zsh -i -c exit

# Check plugin loading times
zinit times
```

**Missing completions:**
```sh
# Rebuild completion cache
rm -f ~/.zcompdump*
autoload -U compinit && compinit
```

**Vi mode not working:**
```sh
# Check if zsh-vi-mode is loaded
zinit list | grep vi-mode

# Reload plugin
zinit delete jeffreytse/zsh-vi-mode
zinit load jeffreytse/zsh-vi-mode
```

### Tool Issues

**Homebrew packages not found:**
```sh
# Reinstall missing packages
brew bundle --force

# Check for outdated packages
brew outdated
brew upgrade
```

**Git authentication problems:**
```sh
# Reconfigure GitHub CLI
gh auth logout
gh auth login

# Check git credentials
git config --list | grep credential
```

**Zellij layouts not loading:**
```sh
# Check layout files exist
ls ~/.config/zellij/layouts/

# Test layout manually
zellij -l general
```

### Neovim Issues

**LazyVim not loading:**
```sh
# Check for plugin errors
nvim --headless +checkhealth +qa

# Reinstall LazyVim
rm -rf ~/.local/share/nvim
nvim  # Will trigger lazy installation
```

**Font rendering issues:**
```sh
# Verify Nerd Font installation
fc-list | grep -i jetbrains

# Reinstall font
brew uninstall --cask font-jetbrains-mono-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
```

## Maintenance

### Weekly Maintenance
```sh
# Update all tools and configurations
brew update && brew upgrade
dotfiles-health
zinit update
```

### Monthly Deep Clean
```sh
# Clean up old backups
find ~/dotfiles-backup-* -type d -mtime +30 -exec rm -rf {} \;

# Clean git branches
git-clean

# Update documentation
tldr --update
```

### Backup Strategy
```sh
# Manual backup before major changes
dotfiles-backup

# Set up automated weekly backups (Sundays at 2 AM)
dotfiles-auto-backup

# Check if automated backup is scheduled
crontab -l | grep auto-backup
```

**Automated Backup Details:**
- Runs every Sunday at 2:00 AM via cron
- Creates timestamped backups in `~/dotfiles-backup-YYYYMMDD-HHMMSS/`
- Backs up: .zshrc, .gitconfig, .p10k.zsh, .config directories
- To disable: `crontab -e` and remove the auto-backup line

## Advanced Configuration

### Adding New Tools

1. Add to `Brewfile`:
   ```sh
   echo 'brew "new-tool"' >> Brewfile
   brew bundle
   ```

2. Update health check:
   ```sh
   # Edit dotfiles-health function in .zshrc
   local tools=("nvim" "tmux" "zellij" "new-tool")
   ```

### Custom Layouts

Create new Zellij layouts in `~/.config/zellij/layouts/`:

```kdl
layout {
  default_tab_template {
    pane size=1 borderless=true {
        plugin location="tab-bar"
    }
    children
    pane size=1 borderless=true {
        plugin location="status-bar"
    }
  }

  tab name="Custom" focus=true {
    pane name="main"
  }
}
```

### Shell Function Development

Add custom functions to `.zshrc`:

```sh
my-function() {
    echo "Custom function logic"
}
```

## Security Notes

- Uses GitHub noreply email for commits
- No secrets or credentials stored in dotfiles
- All configurations are public and safe to share

## License

These dotfiles are personal configurations. Feel free to use and adapt for your own setup.
