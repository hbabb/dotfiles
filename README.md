# dotfiles

My config files for [Omarchy](https://omarchy.org), managed with [chezmoi](https://www.chezmoi.io).

## What's here

| Folder                                       | What it is                                                                                                                      |
| -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| [`dot_config/nvim`](dot_config/nvim)         | My Neovim setup: plain lazy.nvim, one file per plugin, LazyVim's look and keymaps. See its [README](dot_config/nvim/README.md). |
| [`dot_config/sqlfluff`](dot_config/sqlfluff) | Fallback SQL lint/format settings (ANSI dialect) for projects that don't have their own `.sqlfluff`.                            |

chezmoi names files by where they go: `dot_config/nvim` is installed as `~/.config/nvim`.

## Install on a new machine

1. Install chezmoi:

   ```sh
   omarchy pkg add chezmoi
   ```

2. Download this repo and copy the files into place:

   ```sh
   chezmoi init --apply hbabb
   ```

3. Open Neovim. lazy.nvim installs the plugins and Mason installs the language servers, linters and formatters on first start.

## Making changes

chezmoi keeps the real copy of these files in `~/.local/share/chezmoi`, which is this repo.

- Edit the files there, then run `chezmoi apply` to copy them into `~/.config`. In Neovim, `<leader>rc` and `<leader>fc` already open that copy.
- After `:Lazy sync` updates plugins, copy the new lock file back with `chezmoi re-add ~/.config/nvim/lazy-lock.json`.
- To delete a file, use `chezmoi destroy <path>`. Deleting it only from this repo leaves the old copy in `~/.config`.

Changes go in through pull requests: one branch and one PR per change.

## Licenses

The Neovim config is GPLv3 (it's based on Radley Lewis's config), and the parts copied from LazyVim are Apache 2.0. See [`dot_config/nvim/LICENSE`](dot_config/nvim/LICENSE) and [`dot_config/nvim/LICENSE-LazyVim`](dot_config/nvim/LICENSE-LazyVim).
