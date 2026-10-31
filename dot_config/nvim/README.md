# Neovim Config

My personal Neovim setup for web and software development on [Omarchy](https://omarchy.org).

It runs on plain [lazy.nvim](https://github.com/folke/lazy.nvim) with **one file per plugin**. It looks and works like LazyVim (same keymaps, which-key popup, command line, dashboard and file picker), but every piece of it is written out in this repo instead of coming from a distribution.

---

## Credits

This config stands on the work of others.

### Radley Lewis

The base of this config is **Radley Lewis's Neovim setup**:

- GitHub: [github.com/radleylewis/nvim](https://github.com/radleylewis/nvim)
- YouTube walkthrough: [Part 1: Options, Keymaps & Plugins](https://youtu.be/cdAMq2KcF4w), [Part 2: LSP, Linters, Formatters, AI Assistance, Completion](https://youtu.be/qp1OcolI6x0), [Part 3: TMUX, Git & Debugging](https://youtu.be/JN4Zbs0ypwM)

The folder layout (`config/`, `plugins/`, `servers/`, `utils/`), the one-file-per-plugin approach, the LSP setup (native `vim.lsp` with efm for linting and formatting), the options, and most of the plugin choices come from his config.

### The Omarchy team

[Omarchy](https://github.com/omacom/omarchy) by DHH and the Omarchy team inspired this setup and shaped how it looks. Their Neovim package (`omarchy-nvim`) showed how Neovim can follow the system theme. This config keeps that working without LazyVim: when the Omarchy theme changes, Neovim changes with it.

### LazyVim

The keymaps, which-key groups, dashboard and several plugin specs are copied from [LazyVim](https://github.com/LazyVim/LazyVim) by [folke](https://github.com/folke), then rewritten so they don't depend on LazyVim. folke also writes lazy.nvim, snacks.nvim, which-key, noice, flash, trouble, todo-comments and persistence, which this config uses.

---

## Why this setup

### Plain lazy.nvim instead of LazyVim

Omarchy ships Neovim with LazyVim. LazyVim works well, but it's a "black box": its Extras system loads plugins and settings that never appear in your own files, so it's hard to see what's running or why.

lazy.nvim on its own (the plugin manager LazyVim is built on) doesn't have that problem. Every plugin has its own file in `lua/plugins/`, even plugins left on their default settings, so each file shows exactly what that plugin does and is easy to change later.

### Keeping the LazyVim look and keymaps

I like how LazyVim looks and works. So the parts that make up its look were added back one plugin at a time, each in its own file:

| Plugin              | What it does                                                                                       |
| ------------------- | -------------------------------------------------------------------------------------------------- |
| `which-key.lua`     | The popup that lists keymaps after you press Space (LazyVim's `helix` layout and group names)      |
| `mini-icons.lua`    | Icons in which-key and other menus                                                                 |
| `noice.lua`         | The command line as a popup in the middle of the screen, plus message popups                       |
| `snacks.lua`        | File finder, file explorer, notifications, terminal, scratch buffers, toggles and the start screen |
| `bufferline.lua`    | Buffer tabs across the top                                                                         |
| `flash.lua`         | Jump anywhere on screen with `s`                                                                   |
| `grug-far.lua`      | Search and replace across files                                                                    |
| `todo-comments.lua` | Highlights and lists `TODO` / `FIX` / `HACK` comments                                              |
| `persistence.lua`   | Saves and restores sessions                                                                        |
| `trouble-nvim.lua`  | Lists for diagnostics, symbols and quickfix                                                        |
| `gitsigns-nvim.lua` | Git change markers in the margin and hunk keymaps                                                  |

### One keymaps file, loaded after plugins start

`lua/config/keymaps.lua` holds all keymaps: mine at the top, LazyVim's at the bottom.

Many of LazyVim's keymaps use snacks.nvim, which isn't loaded yet when Neovim first reads the config. So `config/lazy.lua` loads `keymaps.lua` on the `VeryLazy` event, right after the plugins start. LazyVim does the same.

The leader key (Space) is still set first, in `config/globals.lua`, because plugins need it when they load.

### Where my keymaps clashed with LazyVim's

When one of my keymaps used the same key as LazyVim's, LazyVim's version won. **My original lines are commented out, not deleted**, with a `-- CONFLICT:` note above each one explaining why. To list them all:

```sh
grep -rn CONFLICT ~/.config/nvim/lua
```

| Key                    | Was                              | Now (LazyVim)                                        |
| ---------------------- | -------------------------------- | ---------------------------------------------------- |
| `<leader>c`            | Clear search                     | "code" group. `Esc` clears search.                   |
| `<leader>x`            | Delete without yanking           | "diagnostics/quickfix" group                         |
| `<leader>e`            | NvimTree (removed)               | Snacks explorer                                      |
| `<leader>fr` `ft`      | LSP references, type definitions | Recent files, terminal                               |
| `<leader>sh`           | Split window                     | Help pages. Splits are `<leader>-` and `<leader>\|`. |
| `<leader>bp`           | Previous buffer                  | Pin buffer. Previous buffer is `Shift+H`.            |
| `<leader>gd` `gD` `gS` | Lspsaga definitions              | Git diff and stash. Go to definition is `gd`.        |
| `<leader>d`            | Cursor diagnostics               | "debug" group. Line diagnostics are `<leader>cd`.    |
| `<leader>nd`           | Next diagnostic                  | Notifications. Next diagnostic is `]d`.              |
| `<leader>ca`, `K`      | Lspsaga                          | Neovim's built-in LSP                                |
| `s`                    | mini.surround                    | Flash. Surround moved to `gs`, as in LazyVim.        |
| `n` / `N`              | Centers the screen               | Doesn't center                                       |
| `[i` `]i` `ii` `ai`    | mini.indentscope                 | Snacks scope                                         |

`mini.indentscope` and `mini.notify` are also commented out, because snacks and noice now do those jobs.

**Left out on purpose:**

- `<leader>L` only opens LazyVim's own changelog.
- `<leader>cF` needs the conform formatter, which this config doesn't use (efm handles formatting).
- LazyVim's "Run Lua" key (`<localleader>r`) is commented out in `keymaps.lua`. My localleader is `\` now, so it no longer clashes and can be turned back on.

### LazyVim helpers replaced

LazyVim's keymaps call LazyVim's own functions. Those were swapped for plain Neovim or snacks:

- **`LazyVim.root()`** → `lua/utils/root.lua`, which finds the nearest folder with a `.git` folder, or falls back to the folder Neovim was opened in.
- **`LazyVim.pick(...)`** → direct `Snacks.picker` calls.
- **`LazyVim.format()`** → `vim.lsp.buf.format()`, which uses efm.
- **Auto-format toggles (`<leader>uf` / `<leader>uF`)** → set `vim.g.autoformat` / `vim.b.autoformat`, which the format-on-save in `config/autocmds.lua` checks.

### Omarchy theme sync without LazyVim

Omarchy's own setup links `lua/plugins/theme.lua` to the current Omarchy theme's `neovim.lua`. Those theme files are written for LazyVim (they set the colorscheme through a `LazyVim/LazyVim` block).

`lua/plugins/ui/omarchy-theme.lua` replaces that link:

- It reads `~/.local/state/omarchy/current/theme/neovim.lua`, takes the colorscheme name from the LazyVim block, and loads the theme plugins.
- It watches that folder. When you change the Omarchy theme, Neovim switches colors right away, downloading the colorscheme first if it isn't installed.
- If something goes wrong it falls back to the built-in `habamax` colorscheme instead of erroring.

Omarchy's `all-themes.lua` (which downloads every Omarchy colorscheme up front) isn't needed, since themes download when first used. `disable-news-alert.lua` was dropped too, because it only applies to LazyVim.

### Start screen

The start screen is the snacks dashboard with LazyVim's logo and menu. "Lazy Extras" was left out because it only exists in LazyVim.

Two details:

- **The logo is stored as a list of lines and padded to equal width when Neovim starts.** Format-on-save runs `mini.trailspace`, which removes spaces at the end of lines. The logo needs those spaces to line up, so saving `snacks.lua` used to break it.
- **mini.trailspace is turned off on the dashboard.** It paints end-of-line spaces red, and the dashboard pads every line with spaces to center it.

### Markdown and notes

- **render-markdown.nvim** draws markdown inside Neovim with its Obsidian preset, so headings, checkboxes and callouts stay drawn while typing. `:RenderMarkdown toggle` turns it off.
- **obsidian.nvim** works with the notes folder in `plugins/coding/obsidian-nvim.lua` (`<leader>o` keys). It only loads when that folder exists.
- **live-preview.nvim** shows the file in the browser with `:LivePreview start`. It replaced markdown-preview.nvim, which needed a separate build step and hasn't been updated since 2023.

### Languages and tools

Language servers are set up with Neovim's own `vim.lsp.config` / `vim.lsp.enable`, one file per server in `lua/servers/`. Linters and formatters run through efm (`servers/efm-langserver.lua`). Mason installs and updates all of them on startup (`plugins/lsp/mason-tool-installer.lua`).

| Language                      | Language server                               | Lint / format                                     |
| ----------------------------- | --------------------------------------------- | ------------------------------------------------- |
| Go, templ                     | gopls, templ                                  | revive, gofumpt                                   |
| Python                        | pyright (uses the project's `.venv`)          | ruff                                              |
| TypeScript, JavaScript, React | ts_ls                                         | eslint_d, prettierd                               |
| Vue                           | vue_ls + ts_ls                                | eslint_d, prettierd                               |
| Svelte                        | svelte + ts_ls                                | eslint_d, prettierd                               |
| HTML, CSS, Tailwind, HTMX     | emmet_ls, tailwindcss, htmx                   | prettierd                                         |
| Flask / Jinja templates       | the HTML servers above, for `.html` templates | djlint                                            |
| Rust                          | rust-analyzer (via rustaceanvim)              | rustfmt                                           |
| C / C++                       | clangd                                        | cpplint, clang-format                             |
| R                             | r_language_server                             | lintr, styler (R packages)                        |
| Ruby                          | ruby_lsp                                      | ruby_lsp                                          |
| Lua                           | lua_ls + lazydev                              | luacheck, stylua                                  |
| Bash, Fish, Nushell           | bashls, fish_lsp, nushell                     | shellcheck, shfmt, fish_indent                    |
| SQL                           | postgres_lsp (Postgres projects)              | sqlfluff (dialect from the project's `.sqlfluff`) |
| JSON, YAML, TOML, Docker      | jsonls, yamlls, tombi, dockerls               | fixjson, prettierd, tombi, hadolint               |

Format on save is on by default. `<leader>uf` turns it off globally, `<leader>uF` for the current buffer.

### Completion

blink.cmp is the completion menu, with snippets from friendly-snippets. `<leader>a` turns completion off and on. `Ctrl+j` / `Ctrl+k` move through the list and `Enter` accepts.

### Finding files

The Snacks picker and explorer handle finding files, text search and the file tree. Yazi (`<leader>y`) is there for full file management. Hidden files (dotfiles) show up in the file finder, text search and explorer; files in `.gitignore` stay hidden, and the explorer skips `.git`.

My old fzf-lua keys kept their letters and now open Snacks: `<leader>fh` help, `<leader>fx` / `fX` diagnostics, `<leader>fs` / `fS` / `fw` symbols, `<leader>fi` implementations.

### Debugging and tests

- **Debugging** uses nvim-dap with nvim-dap-ui (`<leader>d` keys). Go uses Delve (nvim-dap-go), Python uses debugpy (nvim-dap-python), and Rust uses codelldb (rustaceanvim).
- **Tests** use neotest (`<leader>t` keys) with gotestsum for Go and pytest / unittest for Python. `<leader>td` debugs the nearest test.

### Editing this config with chezmoi

This folder is managed by chezmoi, so the real copy lives in `~/.local/share/chezmoi/dot_config/nvim`. `<leader>rc`, `<leader>fc` and the dashboard's "Config" open that copy (found with `chezmoi source-path`). Run `chezmoi apply` after editing to update `~/.config/nvim`.

### Smaller choices

- **Insert-mode cursor is a beam** (`i-ci-ve:ver25` in `config/options.lua`). Normal mode stays a block.
- **Snacks scroll animation is off**, matching Omarchy's default.

---

## Layout

```
~/.config/nvim
├── init.lua                  -- loads config/lazy.lua
├── plugin
│   └── transparency.lua      -- clears editor backgrounds (re-applied on theme change)
└── lua
    ├── config
    │   ├── globals.lua       -- leader keys (loaded first)
    │   ├── options.lua       -- editor options
    │   ├── autocmds.lua      -- format on save, LSP attach, yank highlight
    │   ├── keymaps.lua       -- my keymaps + LazyVim's (loaded on VeryLazy)
    │   └── lazy.lua          -- installs lazy.nvim and loads everything
    ├── plugins               -- one file per plugin
    │   ├── coding            -- completion, treesitter, tests, markdown, notes
    │   ├── debug             -- nvim-dap and the language debuggers
    │   ├── editor            -- snacks, yazi, git, search, sessions
    │   ├── lsp               -- nvim-lspconfig, Mason, lazydev, lspsaga
    │   └── ui                -- theme, status line, tabs, which-key, noice
    ├── servers               -- one file per language server, plus efm
    └── utils
        ├── config_dir.lua    -- finds this config in chezmoi's source
        ├── diagnostics.lua   -- diagnostic signs and display
        ├── lsp.lua           -- LSP keymaps (runs when a server attaches)
        └── root.lua          -- finds the project root
```

---

## Requirements

- **Neovim 0.12 or newer.** The LSP setup uses `vim.lsp.enable`, which arrived in 0.11.
- **A Nerd Font** for icons. Omarchy ships JetBrainsMono Nerd Font.
- **Omarchy**, for theme sync. On other systems the colorscheme falls back to `habamax`.
- **`git`**, so lazy.nvim can download plugins.
- **`lazygit`** (optional), for `<leader>gg`. Omarchy includes it.
- **An Obsidian notes folder** (optional) at the path set in `plugins/coding/obsidian-nvim.lua`. Without it, obsidian.nvim stays off.
- **`yazi`** for `<leader>y`, and **`fd`** for venv-selector.
- **R** installed, for the R language server.

---

## License

Radley Lewis's config, which this is based on, is released under **GPLv3**, so this config is too.

Code copied from LazyVim is under LazyVim's **Apache 2.0** license.
