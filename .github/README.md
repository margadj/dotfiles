# dotfiles

Personal macOS config: zsh, tmux, Neovim, Claude Code, Homebrew.

## How it works

A bare git repo at `~/.dotfiles` with `$HOME` as the work tree, so there are no symlinks.
`~/.gitignore` ignores everything (`*`) and whitelists the tracked paths.

```sh
alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

## What's tracked

| Path | What |
|---|---|
| `.zshrc` | oh-my-zsh + powerlevel10k, vi mode, aliases, PATH for bun / pnpm / nvm / Android |
| `.tmux.conf` | TPM plugins, Tokyo Night theme, vim-tmux-navigator, resurrect + continuum |
| `.config/nvim/` | Neovim config on lazy.nvim, plugins pinned in `lazy-lock.json` |
| `.claude/` | Claude Code: `CLAUDE.md`, `settings.json`, keybindings, statusline, hook, own skills |
| `.homebrew/Brewfile` | Homebrew formulae, casks, VS Code extensions, Go / npm globals |

## New machine

```sh
# 1. Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# 2. Check out the dotfiles into $HOME
git clone --bare https://github.com/margadj/dotfiles.git "$HOME/.dotfiles"
alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
config checkout   # if it refuses, move the conflicting files aside and rerun

# 3. Packages
brew bundle --global

# 4. oh-my-zsh + powerlevel10k (keeps the checked-out .zshrc)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# 5. tmux plugins: clone TPM, then press prefix + I inside tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Neovim installs lazy.nvim and the plugins on first launch.
The prompt config isn't tracked yet, so run `p10k configure` once.

## Everyday use

```sh
config status
config add ~/.zshrc
config commit -m "zsh: ..."
config push
```

To track a new file, first add a `!path` line to `~/.gitignore`, then `config add` it.
For a file inside a directory, the directory must be whitelisted too. See the `.config/` block in `~/.gitignore`.

To refresh the Brewfile after installing or removing packages:

```sh
brew bundle dump --global --force
```

## Never commit

- Credentials: `~/.ssh/`, `~/.config/gh/hosts.yml`, `.env` files, API tokens
- Machine-local state: `~/.claude.json`, `~/.claude/projects/`, shell and prompt history, `~/.claude/skills/synced/`, third-party skills installed by tools
