# dotfiles

macOS development environment, managed with [chezmoi](https://chezmoi.io).

## Bootstrap a new machine

```sh
# 1. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. chezmoi + these dotfiles
brew install chezmoi
chezmoi init --apply guitsaru

# 3. Everything else
brew bundle install --global
```

## What's here

| Path | Purpose |
|---|---|
| `dot_zshrc` | History, completions, fzf keybindings, mise + starship |
| `dot_zprofile` | Homebrew shellenv, ssh keychain load, OrbStack |
| `dot_gitconfig` | git config, delta pager, SSH commit signing, aliases |
| `dot_Brewfile` | All formulae and casks (`brew bundle --global`) |
| `dot_config/starship.toml` | Prompt |
| `dot_config/ghostty/config` | Terminal |
| `dot_config/zed/settings.json` | Editor |
| `dot_config/mise/config.toml` | Elixir / Erlang / Node versions |
| `dot_claude/` | Claude Code config |

## Daily use

```sh
chezmoi edit ~/.zshrc     # edit the source, not the target
chezmoi diff              # preview pending changes
chezmoi apply             # apply them
chezmoi cd                # drop into the source repo
```

## Notes

- Toolchain versions are pinned in `dot_config/mise/config.toml`, not the Brewfile.
- `rustc`/`cargo` resolve via `/opt/homebrew/opt/rustup/bin` — `~/.cargo/bin` is empty, so that PATH entry in `.zshrc` is load-bearing.
- Commits are SSH-signed; `~/.ssh/allowed_signers` is required for local verification and is not tracked here.
- Secrets and machine-local state are excluded via `.chezmoiignore`.
