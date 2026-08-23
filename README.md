# dotfiles

macOS development environment, managed with [mise](https://mise.jdx.dev).

## Bootstrap a new machine

```sh
curl https://mise.run | sh && \
  git clone https://github.com/guitsaru/dotfiles ~/.dotfiles && \
  cd ~/.dotfiles && mise trust && mise bootstrap -y --force-dotfiles
```

`mise bootstrap` runs every phase in order: it installs the packages, symlinks
the dotfiles, fixes the permissions git cannot carry, installs the `[tools]`
toolchains, and finally installs the herdr plugins. It converges -- anything
already in its desired state is skipped, so re-running is always safe.

Homebrew is not a prerequisite. mise pours bottles into the Homebrew prefix
itself, reading the formulae.brew.sh API and verifying checksums, and creates
the prefix if it does not exist. It writes brew-compatible receipts, so if you
do install Homebrew later, `brew list`, `brew upgrade` and `brew uninstall` all
work on formulae mise poured. Casks are the exception -- those carry a mise
receipt and are upgraded with `mise bootstrap packages upgrade`.

`--force-dotfiles` matters only when adopting a machine that already has these
files: mise refuses to replace real files it does not manage. On a genuinely
clean machine it is a no-op.

Two casks are pkg installers and need an interactive sudo, so they are the one
thing the one-liner cannot finish unattended:

```sh
mise bootstrap packages apply brew-cask:tailscale-app brew-cask:zoom
```

The repo can live anywhere; sources resolve relative to `mise.toml`, not to a
hardcoded root. `~/.dotfiles` is just the path the one-liner picks.

## What's here

| Path | Purpose |
|---|---|
| `mise.toml` | Packages, dotfile mappings, bootstrap hooks, and the herdr plugin task |
| `home/` | Everything symlinked into `$HOME`, mirroring its layout |
| `home/.config/mise/config.toml` | Elixir / Erlang / Node / Rust versions |
| `scripts/merge-claude-settings.py` | Merges owned keys into `~/.claude/settings.json` |

macOS preferences that differ from stock live in `[bootstrap.macos.*]`: Dock
autohide, tile size, recents and mru-spaces; Finder's list view; and a set of
global-domain settings — natural scrolling off, dark mode, 24-hour time, metric
units. Keyboard preferences are stock and deliberately undeclared.

The friendly `[bootstrap.macos.*]` sections cover only a handful of keys each,
so read the domain (`defaults read NSGlobalDomain`) rather than trusting the
friendly key list — scroll direction has no friendly key at all. OS-managed
state (`AK*`, `NSLinguistic*`, `NSSpellChecker*`) is deliberately excluded;
it is not preference and should not be pinned.

## Daily use

Targets are symlinks into `home/`, so editing `~/.zshrc` edits the repo
directly -- there is no apply step for ordinary changes.

```sh
mise bootstrap dotfiles status   # what is applied, what drifted
mise bootstrap dotfiles add ~/.foo   # start managing a new file
mise bootstrap dotfiles apply    # re-link after adding entries
mise bootstrap -y                # full converge (packages, tools, plugins)
```

`mise bootstrap --dry-run` prints what would happen. It deliberately does not
render templates, so `~/.claude/settings.json` shows as `(if changed)` rather
than being evaluated.

## Notes

- Toolchain versions are pinned in `home/.config/mise/config.toml`; system
  packages live in `[bootstrap.packages]` in `mise.toml`. The two are separate
  on purpose -- `[tools]` is per-project versioned runtimes, packages are
  machine-wide.
- `~/.config/nvim` is symlinked as a whole directory, so lazy.nvim writes
  `lazy-lock.json` and `lazyvim.json` straight into the repo. Plugin bumps show
  up in `git status` with nothing to sync.
- `~/.claude/settings.json` is a rendered template rather than a symlink:
  Claude rewrites the file in place and generates a machine-local
  `autoMode.environment` block that must not be published. The template merges
  only the keys we own and passes the rest through.
- There is no `defaults import`, so macOS preferences are captured by hand.
  `mise bootstrap macos defaults status` reports each as set / differs / unset.
  Typing is strict: `com.apple.dock tilesize` is stored as a float, and the
  friendly `tilesize` key is integer-only, so it is declared under raw
  `[bootstrap.macos.defaults]` instead -- otherwise it reads as permanent drift.
- `mise bootstrap packages import --manager brew` re-derives the formula list
  from what is installed, and is the check to run after adding one by hand.
  There is no cask equivalent: cask import is not implemented, so casks are
  maintained by hand in `[bootstrap.packages]`.
- git records only the executable bit, so the `post-dotfiles` hook restores
  `0600` on `~/.ssh/config`, `~/.config/gh/config.yml`,
  `~/.config/zed/settings.json`, and `~/.claude/settings.json`.
- Commits are SSH-signed; `~/.ssh/allowed_signers` is required for local
  verification and is not tracked here.
- `~/.gitconfig.local` holds the absolute repo paths used by `git maintenance`
  and is deliberately untracked.
