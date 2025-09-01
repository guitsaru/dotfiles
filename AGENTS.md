# AGENTS.md - Dotfiles Repository Guidelines

## Build/Test Commands
```bash
# Validation & Testing
bash .config/scripts/setup-validate.sh  # Validate all tools/configs installed
dotfiles-health                          # Check system health (after sourcing .zshrc)
zsh -i -c exit                          # Test shell startup time (<1.0s target)
```

## Dotfiles Management
```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/code/.dotfiles/ --work-tree=$HOME'
dotfiles add <file>                     # Stage config files
dotfiles commit -m "message"            # Commit changes  
dotfiles push                           # Push to remote
brew bundle                             # Install packages from Brewfile
```

## Code Style & Conventions
- **Shell Scripts**: Use bash/zsh with `set -e`, color variables (RED/GREEN/BLUE/NC)
- **Config Files**: Follow XDG Base Directory spec (.config/ subdirectories)
- **Naming**: Kebab-case for scripts (setup-validate.sh), snake_case for functions
- **Error Handling**: Check command existence with `command -v`, handle failures gracefully
- **Neovim**: LazyVim distribution, Lua configs in lua/config/ and lua/plugins/
- **Documentation**: Update README.md for new tools, maintain CLAUDE.md for AI context