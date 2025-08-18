# Zellij Layouts Documentation

## Overview

This document describes the optimized Zellij layouts for efficient development workflows. All layouts are designed with resource efficiency in mind, using suspended services that start on-demand.

## Layout Comparison

| Layout | Best For | Key Features | Resource Usage |
|--------|----------|--------------|----------------|
| `elixir.kdl` | Elixir/Phoenix development | Phoenix server, IEx console, ExUnit tests | Low (services suspended) |
| `rails.kdl` | Ruby/Rails development | Rails server, console, DB, logs, guard | Low (services suspended) |
| `general.kdl` | Any project type | Split editor/terminal, file browser, floating panes | Very Low |
| `docs.kdl` | Documentation & writing | Live preview, spell check, research workspace | Low |

## Layout Details

### 1. Elixir Layout (`elixir.kdl`)

**Use Case**: Elixir and Phoenix application development

**Tabs**:
- **Editor** (focus): Opens project root in Neovim
- **Terminal**: General command execution
- **Server**: Phoenix server via IEx (suspended)
- **Console**: IEx REPL with Mix environment (suspended)
- **Tests**: ExUnit test runner with stdin listening (suspended)
- **Git**: LazyGit interface (suspended)

**Workflow**:
1. Start in Editor tab for coding
2. Use `Ctrl+a s` to start Phoenix server in Server tab
3. Switch to Console tab for IEx experimentation
4. Run tests in Tests tab when needed
5. Use Git tab for version control

**Resource Optimization**:
- All services start suspended to save memory
- Phoenix server only runs when explicitly started
- Test runner uses `--listen-on-stdin` for interactive testing

---

### 2. Rails Layout (`rails.kdl`)

**Use Case**: Ruby on Rails application development

**Tabs**:
- **Editor** (focus): Opens project root in Neovim
- **Terminal**: General command execution
- **Server**: Rails development server (suspended)
- **Console**: Rails console (suspended)
- **Tests**: Split between RSpec runner and Guard watcher (suspended)
- **Database**: Rails database console (suspended)
- **Logs**: Split view of development and test logs (suspended)
- **Git**: LazyGit interface (suspended)

**Workflow**:
1. Start coding in Editor tab
2. Start Rails server when needed for testing
3. Use Console for Rails experimentation
4. Run tests with RSpec or continuous testing with Guard
5. Monitor logs during development
6. Use Database tab for SQL operations

**Advanced Features**:
- Split test tab with RSpec and Guard
- Log monitoring with `tail -f`
- Dedicated database console access

---

### 3. General Layout (`general.kdl`)

**Use Case**: Any development project, language-agnostic

**Tabs**:
- **Main** (focus): Split layout with editor (70%), terminal and file browser (30%)
- **Terminal**: Full-screen terminal
- **Git**: LazyGit with additional git terminal (suspended)
- **Tasks**: Split pane for build and test operations (suspended)

**Special Features**:
- **Floating Panes**: Quick terminal accessible with `Alt+f`
- **File Browser**: Integrated file manager in main view
- **Split Views**: Efficient screen real estate usage

**Workflow**:
1. Work primarily in Main tab with integrated editor/terminal
2. Use file browser for navigation
3. Switch to Git tab for version control
4. Use Tasks tab for build/test operations
5. Access floating terminal for quick commands

---

### 4. Documentation Layout (`docs.kdl`)

**Use Case**: Writing documentation, markdown files, technical writing

**Tabs**:
- **Writing** (focus): Split editor with file browser and notes terminal
- **Preview**: Side-by-side markdown editing with live preview
- **Terminal**: General command execution
- **Git**: LazyGit with git status monitoring (suspended)
- **Research**: Dedicated workspace for research and references

**Features**:
- **Live Preview**: Uses `glow` for markdown rendering (with fallback)
- **Spell Check**: Integration with `aspell` (with installation check)
- **File Navigation**: Integrated file browser for document management
- **Git Monitoring**: Automatic git status updates every 2 seconds

**Workflow**:
1. Write in Writing tab with integrated file browser
2. Preview markdown in Preview tab
3. Use Research tab for gathering references
4. Monitor git changes automatically

---

## Keybinds Reference

### Global Shortcuts (Available in all modes)

| Keybind | Action | Description |
|---------|--------|-------------|
| `Ctrl+g` | Lock mode | Switch to locked mode (safe mode) |
| `Ctrl+q` | Quit | Exit Zellij |
| `Alt+f` | Float toggle | Toggle floating panes |
| `Alt+h/j/k/l` | Navigation | Move between panes (vim-style) |
| `Alt+arrows` | Navigation | Move between panes/tabs |
| `Alt+n` | New pane | Create new pane |
| `Alt+[/]` | Layouts | Previous/next swap layout |

### Development Shortcuts (Custom)

| Keybind | Action | Command |
|---------|--------|---------|
| `Ctrl+a r` | Restart prompt | Prompts for service restart |
| `Ctrl+a s` | Phoenix server | Types `mix phx.server` |
| `Ctrl+a t` | Run tests | Types `mix test` |
| `Ctrl+a c` | Compile | Types `mix compile` |
| `Ctrl+a g` | Git interface | Types `lazygit` |

### Mode-Specific Shortcuts

**Pane Mode** (`p` to enter):
- `h/j/k/l`: Move focus between panes
- `n`: Create new pane
- `x`: Close current pane
- `f`: Toggle fullscreen
- `e`: Toggle floating

**Tab Mode** (`t` to enter):
- `h/l`: Move between tabs
- `n`: Create new tab
- `x`: Close current tab
- `1-9`: Jump to tab by number

## Service Management

### Starting Services

All layouts use suspended services to optimize resource usage. To start a service:

1. Navigate to the appropriate tab
2. Press `Enter` in the pane to start the suspended command
3. Or use the custom keybinds (`Ctrl+a` combinations)

### Stopping Services

- `Ctrl+c` in the pane to stop the service
- `Ctrl+d` to exit shells/REPLs cleanly
- Close the pane with `x` in pane mode

## Layout Selection Logic

The `project` function in your `.zshrc` automatically detects project types:

```bash
project <project-name>
```

**Detection Rules**:
- `mix.exs` present → `elixir` layout
- `Gemfile` with rails → `rails` layout  
- `README.md` or `docs/` → `docs` layout
- Default → `general` layout

## Performance Tips

### Memory Usage
- Services start suspended to minimize memory usage
- Only start services you actually need
- Close unused panes to free resources

### Startup Time
- Layouts load instantly since services are suspended
- File browsers and editors load project root efficiently
- Floating panes provide quick access without permanent overhead

### Best Practices
1. Use suspended services - start only when needed
2. Leverage split panes for related tasks
3. Use floating panes for temporary operations
4. Close tabs/panes you're not actively using
5. Use keybinds for faster navigation

## Troubleshooting

### Common Issues

**Services won't start**:
- Check if you're in the correct project directory
- Verify the command exists (`which mix`, `which rails`)
- Check project dependencies are installed

**Layout not loading**:
- Verify layout file exists: `ls ~/.config/zellij/layouts/`
- Check layout syntax: `zellij -l <layout-name> --check`
- Look for typos in the .kdl file

**File browser not working**:
- The `file_manager` plugin may not be available in your Zellij version
- Fallback: Use a regular terminal pane with `eza` or `tree`

**Live preview not working**:
- Install glow: `brew install glow`
- Check if file exists: `ls README.md`
- Use fallback `cat` command shown in the layout

### Performance Issues

**High memory usage**:
- Check if services are properly suspended: `ps aux | grep <service>`
- Close unused tabs and panes
- Restart Zellij session

**Slow response**:
- Reduce number of split panes
- Close log monitoring panes when not needed
- Check if `watch` commands are running efficiently

## Customization

### Adding New Layouts

1. Create new `.kdl` file in `~/.config/zellij/layouts/`
2. Follow the existing template structure
3. Use `start_suspended=true` for resource-intensive services
4. Test with: `zellij -l <new-layout>`

### Modifying Existing Layouts

1. Edit the `.kdl` files directly
2. Restart Zellij or reload configuration
3. Test changes thoroughly before committing

### Custom Keybinds

Edit `~/.config/zellij/config.kdl` in the `shared_among` section to add project-specific shortcuts.

## Integration with Claude Code

These layouts work seamlessly with Claude Code workflows:

### Planning Phase
- Use any layout for analysis and planning
- Terminal access for file exploration
- Git integration for understanding codebase

### Implementation Phase  
- Services start on-demand to save resources during AI interaction
- Split panes allow side-by-side code review
- Quick access to tests and compilation

### Review Phase
- Git tabs provide easy diff viewing
- Editor integration for applying changes
- Service management for testing changes

The suspended service approach is particularly beneficial when using Claude Code, as it prevents resource waste during planning and analysis phases while keeping development tools readily available.