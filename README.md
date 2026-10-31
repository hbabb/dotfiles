# dotfiles

My config files for [Omarchy](https://omarchy.org), managed with [chezmoi](https://www.chezmoi.io).

## What's here

| Folder                                                       | What it is                                                                                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| [`dot_config/nvim`](dot_config/nvim)                         | My Neovim setup: plain lazy.nvim, one file per plugin, LazyVim's look and keymaps. See its [README](dot_config/nvim/README.md). |
| [`dot_config/git`](dot_config/git)                           | My git config.                                                                                                                  |
| [`dot_config/private_jj`](dot_config/private_jj)             | My jj config. `private_` makes chezmoi install it as `~/.config/jj` readable only by me.                                        |
| [`dot_config/tmux`](dot_config/tmux)                         | My tmux config, with TPM for plugins. Prefix is `Ctrl+b`.                                                                       |
| [`dot_config/sqlfluff`](dot_config/sqlfluff)                 | Fallback SQL lint/format settings (ANSI dialect) for projects that don't have their own `.sqlfluff`.                            |
| [`dot_zshrc`](dot_zshrc), [`dot_config/zsh`](dot_config/zsh) | My zsh setup: Omarchy's zsh config plus my own files, one per topic, with Oh My Zsh. `.zshrc` loads them in order.              |

chezmoi names files by where they go: `dot_config/nvim` is installed as `~/.config/nvim`.

## Install on a new machine

1. Install chezmoi:

   ```sh
   omarchy pkg add chezmoi
   ```

2. Install the packages the zsh config uses:

   ```sh
   sudo pacman -S --needed omarchy-zsh zsh-autosuggestions zsh-history-substring-search atuin
   ```

3. Download this repo and copy the files into place:

   ```sh
   chezmoi init --apply hbabb
   ```

   This also downloads Oh My Zsh into `~/.oh-my-zsh` (set in [`.chezmoiexternal.toml`](.chezmoiexternal.toml)).

4. Switch to zsh:

   ```sh
   omarchy-setup-zsh
   ```

   The first zsh start downloads fast-syntax-highlighting into `~/.config/zsh/plugins`.

5. Open Neovim. lazy.nvim installs the plugins and Mason installs the language servers, linters and formatters on first start.

## Making changes

chezmoi keeps the real copy of these files in `~/.local/share/chezmoi`, which is this repo.

- Edit the files there, then run `chezmoi apply` to copy them into `~/.config`. In Neovim, `<leader>rc` and `<leader>fc` already open that copy.
- After `:Lazy sync` updates plugins, copy the new lock file back with `chezmoi re-add ~/.config/nvim/lazy-lock.json`.
- To delete a file, use `chezmoi destroy <path>`. Deleting it only from this repo leaves the old copy in `~/.config`.
- Oh My Zsh isn't stored here. `chezmoi apply` downloads it again at most once a week; `chezmoi -R apply` gets the latest right away.
- Machine-only zsh settings and secrets go in `~/.config/zsh/local.zsh`. It isn't in this repo.

Changes go in through pull requests: one branch and one PR per change.

## Licenses

The Neovim config is GPLv3 (it's based on Radley Lewis's config), and the parts copied from LazyVim are Apache 2.0. See [`dot_config/nvim/LICENSE`](dot_config/nvim/LICENSE) and [`dot_config/nvim/LICENSE-LazyVim`](dot_config/nvim/LICENSE-LazyVim).
