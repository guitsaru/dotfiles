# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Context

This is a personal dotfiles repository that manages system configurations using a bare Git repository approach. The dotfiles are designed to be deployed directly to the user's home directory.

## Setup and Management Commands

**Initial Setup:**
```bash
git clone --bare https://github.com/guitsaru/dotfiles.git $HOME/code/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/code/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
brew bundle
```

**Package Management:**
```bash
brew bundle                    # Install all packages from Brewfile
brew bundle dump --force      # Update Brewfile with currently installed packages
brew bundle cleanup --force   # Remove packages not in Brewfile
```

**Dotfiles Management:**
```bash
dotfiles status               # Check repository status
dotfiles add <file>          # Stage configuration files
dotfiles commit -m "message" # Commit changes
dotfiles push                # Push to remote
```

## Architecture and Structure

### Configuration Organization
- **Root level**: Core shell configs (.zshrc, .gitconfig, Brewfile, README.md)
- **.config/**: XDG Base Directory compliant application configurations
  - `ghostty/`: Terminal emulator configuration
  - `nvim/`: Neovim editor configuration (LazyVim-based)
  - `tmux/`: Terminal multiplexer configuration
  - `zed/`: Zed editor settings and tasks
  - `zellij/`: Terminal workspace manager with custom layouts
  - `zsh/`: Shell configuration with Oh My Zsh integration

### Key Tools and Environment
- **Package Manager**: Homebrew with Brewfile for reproducible installs
- **Shell**: Zsh with Oh My Zsh framework and robbyrussell theme
- **Editor**: Neovim with LazyVim distribution
- **Terminal**: Ghostty terminal emulator
- **Multiplexer**: Choice between tmux and zellij
- **Version Control**: Git with custom aliases and delta for diffs
- **CLI Tools**: Modern replacements (eza, bat, ripgrep, fd, fzf, zoxide)

### Git Configuration Patterns
- Custom aliases for common operations (c, a, di, pl, ps, st, lg)
- Delta integration for enhanced diff viewing
- Automatic rebase on pull
- Main branch as default
- GitHub CLI integration for authentication

### Development Environment Features
- **Vi Mode**: Enabled in zsh for modal editing
- **Custom Layouts**: Zellij layouts for specific project types (elixir.kdl)
- **Editor Integration**: Neovim as default git editor with LazyVim plugins
- **Terminal Navigation**: Consistent vim-style navigation across tmux/zellij
- **Font**: JetBrains Mono Nerd Font for consistent typography

## Workflow Patterns

When modifying configurations:
1. **DO** work on files within this repository (not deployed locations)
2. **DO** use standard `git add`, `git commit`, `git push` commands
3. **DO** use `dotfiles pull` after pushing to deploy changes to live system
4. Commit with descriptive messages about what functionality changed
5. For package additions, update Brewfile and commit separately

When adding new tools:
1. Add to Brewfile if it's a system-wide tool
2. Create configuration in appropriate `.config/` subdirectory
3. Update shell aliases or path modifications in `.config/zsh/.zshrc`
4. Test the full setup workflow to ensure reproducibility

## Document Management

This repository now includes a `/docs/` directory for structured documentation:

- **PRDs**: Product Requirements Documents in `/docs/prd/PRD-{###}-{title}.md`
- **ADRs**: Architecture Decision Records in `/docs/adr/ADR-{###}-{title}.md`  
- **Epics**: Epic breakdowns in `/docs/epics/EPIC-{###}-{name}-breakdown.md`

### Documentation Workflow
1. Create docs on feature branch: `docs/{type}-{###}-{title}`
2. Submit PR for document review before implementation
3. Link GitHub issues to approved documentation
4. Use GitHub milestones and sub-issues for task management