#!/bin/bash

# Dotfiles Setup Validation Script
# Validates that all tools and configurations are properly installed

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 Dotfiles Setup Validation${NC}"
echo "=================================="

# Track validation results
passed=0
failed=0
warnings=0

check_command() {
    local cmd=$1
    local name=${2:-$cmd}
    
    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ $name${NC}"
        ((passed++))
    else
        echo -e "${RED}❌ $name${NC}"
        ((failed++))
    fi
}

check_file() {
    local file=$1
    local name=${2:-$file}
    
    if [[ -f "$file" ]]; then
        echo -e "${GREEN}✅ $name${NC}"
        ((passed++))
    else
        echo -e "${RED}❌ $name${NC}"
        ((failed++))
    fi
}

check_directory() {
    local dir=$1
    local name=${2:-$dir}
    
    if [[ -d "$dir" ]]; then
        echo -e "${GREEN}✅ $name${NC}"
        ((passed++))
    else
        echo -e "${RED}❌ $name${NC}"
        ((failed++))
    fi
}

# Check core tools
echo -e "\n${BLUE}Core Tools:${NC}"
check_command "zsh" "Zsh Shell"
check_command "git" "Git"
check_command "brew" "Homebrew"
check_command "nvim" "Neovim"

# Check development tools
echo -e "\n${BLUE}Development Tools:${NC}"
check_command "tmux" "Tmux"
check_command "zellij" "Zellij"
check_command "lazygit" "LazyGit"
check_command "fzf" "FZF"
check_command "rg" "Ripgrep"
check_command "fd" "fd"
check_command "eza" "eza"
check_command "bat" "bat"
check_command "zoxide" "zoxide"
check_command "gh" "GitHub CLI"

# Check new tools
echo -e "\n${BLUE}Enhanced Tools:${NC}"
check_command "delta" "Git Delta"
check_command "starship" "Starship Prompt"
check_command "direnv" "direnv"
check_command "tldr" "tldr"
check_command "jq" "jq"
check_command "tree" "tree"

# Check configurations
echo -e "\n${BLUE}Configuration Files:${NC}"
check_file "$HOME/.zshrc" "Zsh Config"
check_file "$HOME/.gitconfig" "Git Config"
check_file "$HOME/.p10k.zsh" "Powerlevel10k Config"
check_file "$HOME/.config/ghostty/config" "Ghostty Config"
check_file "$HOME/.config/tmux/tmux.conf" "Tmux Config"
check_file "$HOME/.config/zellij/config.kdl" "Zellij Config"

# Check layouts
echo -e "\n${BLUE}Zellij Layouts:${NC}"
check_directory "$HOME/.config/zellij/layouts" "Layouts Directory"
check_file "$HOME/.config/zellij/layouts/elixir.kdl" "Elixir Layout"
check_file "$HOME/.config/zellij/layouts/general.kdl" "General Layout"
check_file "$HOME/.config/zellij/layouts/rails.kdl" "Rails Layout"
check_file "$HOME/.config/zellij/layouts/docs.kdl" "Docs Layout"

# Check Neovim setup
echo -e "\n${BLUE}Neovim Setup:${NC}"
check_directory "$HOME/.config/nvim" "Neovim Config"
check_file "$HOME/.config/nvim/init.lua" "Neovim Init"
check_directory "$HOME/.local/share/nvim/lazy" "Lazy.nvim Plugins"

# Check dotfiles repository
echo -e "\n${BLUE}Dotfiles Repository:${NC}"
if [[ -d "$HOME/code/.dotfiles" ]]; then
    echo -e "${GREEN}✅ Dotfiles Repository${NC}"
    ((passed++))
    
    # Check if alias works
    if alias dotfiles >/dev/null 2>&1; then
        echo -e "${GREEN}✅ Dotfiles Alias${NC}"
        ((passed++))
    else
        echo -e "${YELLOW}⚠️  Dotfiles Alias (reload shell)${NC}"
        ((warnings++))
    fi
    
    # Check repository status
    cd "$HOME"
    if /usr/bin/git --git-dir="$HOME/code/.dotfiles/" --work-tree="$HOME" status >/dev/null 2>&1; then
        echo -e "${GREEN}✅ Repository Status${NC}"
        ((passed++))
    else
        echo -e "${RED}❌ Repository Status${NC}"
        ((failed++))
    fi
else
    echo -e "${RED}❌ Dotfiles Repository${NC}"
    ((failed++))
fi

# Check shell plugins
echo -e "\n${BLUE}Shell Plugins:${NC}"
if [[ -d "$HOME/.local/share/zinit" ]]; then
    echo -e "${GREEN}✅ Zinit Plugin Manager${NC}"
    ((passed++))
else
    echo -e "${RED}❌ Zinit Plugin Manager${NC}"
    ((failed++))
fi

# Check fonts
echo -e "\n${BLUE}Fonts:${NC}"
if fc-list 2>/dev/null | grep -qi "jetbrains.*mono.*nerd" || system_profiler SPFontsDataType 2>/dev/null | grep -qi "jetbrains.*mono.*nerd"; then
    echo -e "${GREEN}✅ JetBrains Mono Nerd Font${NC}"
    ((passed++))
else
    echo -e "${YELLOW}⚠️  JetBrains Mono Nerd Font (may need restart)${NC}"
    ((warnings++))
fi

# Performance checks
echo -e "\n${BLUE}Performance Checks:${NC}"

# Check shell startup time
startup_time=$(time zsh -i -c exit 2>&1 | grep real | awk '{print $2}' | sed 's/[^0-9.]//g' | head -1)
if [[ -n "$startup_time" ]]; then
    if (( $(echo "$startup_time < 1.0" | bc -l 2>/dev/null || echo "0") )); then
        echo -e "${GREEN}✅ Shell Startup Time ($startup_time s)${NC}"
        ((passed++))
    else
        echo -e "${YELLOW}⚠️  Shell Startup Time ($startup_time s - consider optimization)${NC}"
        ((warnings++))
    fi
else
    echo -e "${YELLOW}⚠️  Shell Startup Time (could not measure)${NC}"
    ((warnings++))
fi

# Summary
echo -e "\n${BLUE}Validation Summary:${NC}"
echo "=================="
echo -e "${GREEN}✅ Passed: $passed${NC}"
if [[ $warnings -gt 0 ]]; then
    echo -e "${YELLOW}⚠️  Warnings: $warnings${NC}"
fi
if [[ $failed -gt 0 ]]; then
    echo -e "${RED}❌ Failed: $failed${NC}"
fi

# Recommendations
if [[ $failed -gt 0 ]]; then
    echo -e "\n${YELLOW}💡 Recommendations:${NC}"
    echo "• Run 'brew bundle' to install missing tools"
    echo "• Check the troubleshooting guide in README.md"
    echo "• Run 'dotfiles-health' for additional diagnostics"
fi

if [[ $warnings -gt 0 ]]; then
    echo -e "\n${YELLOW}💡 Minor Issues:${NC}"
    echo "• Restart terminal for font changes to take effect"
    echo "• Reload shell for alias changes: 'source ~/.zshrc'"
fi

# Exit code based on results
if [[ $failed -gt 0 ]]; then
    exit 1
else
    echo -e "\n${GREEN}🎉 Setup validation completed successfully!${NC}"
    exit 0
fi