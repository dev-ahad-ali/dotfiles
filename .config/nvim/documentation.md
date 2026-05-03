# Neovim Configuration Documentation

> Modern full-stack web development setup based on **LazyVim** distribution

## Table of Contents

1. [Overview](#overview)
2. [Directory Structure](#directory-structure)
3. [Theme Configuration](#theme-configuration)
4. [Language Support](#language-support)
5. [Plugin Documentation](#plugin-documentation)
6. [Keybindings Reference](#keybindings-reference)
7. [Formatting & Linting](#formatting--linting)
8. [LSP Servers](#lsp-servers)
9. [Mason Tools](#mason-tools)
10. [Troubleshooting](#troubleshooting)

---

## Overview

This Neovim configuration is built on top of **LazyVim** - a Neovim distribution that provides sensible defaults and a powerful plugin management system via `lazy.nvim`.

### Features

- **Languages**: TypeScript, JavaScript, React, Next.js, Astro, MDX, Go, YAML, Docker, PostgreSQL, Prisma, MongoDB, React Native/Expo
- **LSP**: Full LSP support with inline diagnostics
- **Formatting**: Prettier (printWidth=100, tabWidth=4), ESLint auto-fix
- **Git**: Gitsigns + LazyGit integration
- **Navigation**: Harpoon, Telescope, UndoTree
- **Theme**: Aether (v2) with custom color overrides

---

## Directory Structure

```
~/.config/nvim/
├── init.lua                          # Entry point
├── lazyvim.json                      # LazyVim extras configuration
├── lazy-lock.json                    # Locked plugin versions
├── stylua.toml                       # Lua formatter config
├── documentation.md                  # This file
└── lua/
    ├── config/                       # Core Neovim configuration
    │   ├── autocmds.lua              # Autocmds (auto commands)
    │   ├── keymaps.lua               # Custom keybindings
    │   ├── lazy.lua                  # lazy.nvim plugin manager setup
    │   └── options.lua               # Neovim options/settings
    └── plugins/                      # Plugin configurations
        ├── colorscheme.lua           # Aether theme
        ├── completion.lua            # blink.cmp + LuaSnip
        ├── formatting-linting.lua    # conform.nvim + nvim-lint
        ├── git.lua                   # Gitsigns + LazyGit
        ├── lsp.lua                   # LSP servers configuration
        ├── mason-tools.lua           # Mason auto-install tools
        ├── navigation.lua            # Harpoon, Telescope, UndoTree
        ├── neo-tree.lua              # File explorer
        ├── performance.lua           # Performance optimizations
        ├── spellcheck.lua            # Spell checking
        └── sudo.lua                  # Sudo editing support
```

---

## Theme Configuration

**File**: `lua/plugins/colorscheme.lua`

The theme uses **Aether (v2)** with custom color overrides.

### Configuration

```lua
{
  "bjarneo/aether.nvim",
  branch = "v2",
  name = "aether",
  priority = 1000,
  opts = {
    transparent = false,
    colors = {
      bg = "#171717",
      bg_dark = "#171717",
      bg_highlight = "#ac7426",
      fg = "#ACABA9",
      fg_dark = "#4D4D4D",
      comment = "#53533f",
      red = "#aeab94",
      orange = "#fdfd96",
      yellow = "#a9ba9d",
      green = "#828282",
      cyan = "#F56E0F",
      blue = "#88A57D",
      purple = "#f6eabe",
      magenta = "#F56E0F",
    },
    on_highlights = function(hl, c)
      hl.CursorLine = { bg = "#242424" }
      hl.CursorLineNr = { fg = c.orange, bold = true }
    end,
  },
}
```

### Customization

To modify colors, edit the `colors` table in `lua/plugins/colorscheme.lua`. Available color keys:

| Key | Description | Current Value |
|-----|-------------|---------------|
| `bg` | Background color | `#171717` |
| `bg_dark` | Darker background | `#171717` |
| `bg_highlight` | Highlight background | `#ac7426` |
| `fg` | Foreground text | `#ACABA9` |
| `fg_dark` | Dark foreground | `#4D4D4D` |
| `comment` | Comment color | `#53533f` |
| `red` | Red elements | `#aeab94` |
| `orange` | Orange elements | `#fdfd96` |
| `yellow` | Yellow elements | `#a9ba9d` |
| `green` | Green elements | `#828282` |
| `cyan` | Cyan elements | `#F56E0F` |
| `blue` | Blue elements | `#88A57D` |
| `purple` | Purple elements | `#f6eabe` |
| `magenta` | Magenta elements | `#F56E0F` |

### Hot Reload

Aether theme supports hot-reload for development. Changes to colors will be reflected immediately.

---

## Language Support

### Supported Languages

| Language | LSP Server | Treesitter | Formatter | Linter |
|----------|------------|------------|-----------|--------|
| TypeScript/JavaScript | `ts_ls` | `typescript`, `tsx`, `javascript` | `prettier` | `eslint_d` |
| React/Next.js | `ts_ls` | `javascriptreact`, `typescriptreact` | `prettier` | `eslint_d` |
| Astro | `astro` | `astro` | `prettier` | - |
| MDX | `ts_ls` (via davidmh/mdx.nvim) | `mdx` | `prettier` | - |
| Go | `gopls` | `go`, `gomod`, `gowork`, `gosum` | `goimports` | `golangcilint` |
| HTML/CSS/SCSS | - | `html`, `css`, `scss` | `prettier` | - |
| TailwindCSS | `tailwindcss` | - | - | - |
| YAML | `yamlls` | `yaml` | `prettier` | `yamllint` |
| Docker | `dockerls` | `dockerfile` | - | `hadolint` |
| PostgreSQL | `sqlls` | `sql` | `sqlfmt` | - |
| Prisma | `prismals` | `prisma` | - | - |
| MongoDB | `ts_ls` (mongosh) | `sql` | `prettier` | - |
| React Native/Expo | `ts_ls` | `typescriptreact` | `prettier` | `eslint_d` |
| Bash/Shell | `bashls` | `bash` | `shfmt` | `shellcheck` |
| JSON | `json-lsp` | `json` | `prettier` | - |
| Lua | `lua_ls` | `lua` | `stylua` | - |
| Markdown | - | `markdown`, `markdown_inline` | `prettier` | `markdownlint` |

---

## Plugin Documentation

### 1. Completion (`completion.lua`)

**Plugin**: `saghen/blink.cmp` (LazyVim default)

Completion engine with snippet support.

#### Configuration Options

```lua
opts = {
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      lsp = { name = "LSP", enabled = true },
      path = { name = "Path", enabled = true },
      snippets = { name = "Snippets", enabled = true },
      buffer = { name = "Buffer", enabled = true },
    },
  },
  snippets = {
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
  },
}
```

#### Sources Priority

1. **LSP** - Language server completions (highest priority)
2. **Snippets** - LuaSnip snippets
3. **Path** - File path completions
4. **Buffer** - Current buffer word completions

#### Dependencies

- `L3MON4D3/LuaSnip` - Snippet engine
- `rafamadriz/friendly-snippets` - VSCode style snippets collection

---

### 2. LSP Configuration (`lsp.lua`)

**Plugin**: `neovim/nvim-lspconfig`

#### LazyVim Extras Used

```json
{
  "lazyvim.plugins.extras.lang.typescript",  // TypeScript, React, Next.js
  "lazyvim.plugins.extras.lang.astro",       // Astro support
  "lazyvim.plugins.extras.lang.golang",      // Go support
  "lazyvim.plugins.extras.lang.json",        // JSON support
  "lazyvim.plugins.extras.lang.lua"          // Lua support
}
```

#### Custom LSP Servers

| Server | Filetypes | Purpose |
|--------|-----------|---------|
| `yamlls` | `yaml` | YAML with schema validation |
| `prismals` | `prisma` | Prisma schema |
| `tailwindcss` | `html`, `css`, `scss`, `javascript`, `typescript`, `tsx`, `jsx`, `astro`, `mdx` | TailwindCSS intellisense |
| `dockerls` | `dockerfile` | Docker support |
| `sqlls` | `sql` | PostgreSQL/SQL |
| `bashls` | `bash`, `sh` | Bash scripts |
| `tsserver` | `javascript`, `typescript`, `jsx`, `tsx` | React Native/Expo |

#### YAML Schema Support

Pre-configured schemas:
- GitHub Actions: `.github/workflows/*`
- Docker Compose: `docker-compose*.yml`
- Prettier: `.prettierrc`

#### Treesitter Parsers

Automatically installed parsers:
`typescript`, `tsx`, `javascript`, `html`, `css`, `scss`, `json`, `yaml`, `markdown`, `markdown_inline`, `astro`, `mdx`, `go`, `gomod`, `gowork`, `gosum`, `prisma`, `dockerfile`, `sql`, `bash`, `lua`, `vim`, `vimdoc`, `query`, `regex`

---

### 3. Formatting & Linting (`formatting-linting.lua`)

#### Formatter: `stevearc/conform.nvim`

**Prettier Configuration**:
```lua
formatters = {
  prettier = {
    prepend_args = { "--print-width", "100", "--tab-width", "4" },
  },
  prettierd = {
    prepend_args = { "--print-width", "100", "--tab-width", "4" },
  },
}
```

**Format on Save**: Enabled with 500ms timeout and LSP fallback.

**Formatters by Filetype**:

| Filetype | Formatters |
|----------|------------|
| `javascript`, `typescript`, `jsx`, `tsx` | `prettierd`, `prettier`, `eslint_d` |
| `html`, `css`, `scss` | `prettierd`, `prettier` |
| `astro`, `mdx` | `prettierd`, `prettier` |
| `json`, `yaml` | `prettierd`, `prettier` |
| `markdown` | `prettierd`, `prettier` |
| `go` | `goimports`, `gofmt` |
| `lua` | `stylua` |
| `sql` | `sqlfmt` |

#### Linter: `mfussenegger/nvim-lint`

**Linters by Filetype**:

| Filetype | Linter |
|----------|--------|
| `go` | `golangcilint` |
| `yaml` | `yamllint` |
| `dockerfile` | `hadolint` |
| `sh`, `bash` | `shellcheck` |

**ESLint Auto-fix**: Configured via LazyVim's typescript extra to auto-fix on save.

---

### 4. Git Integration (`git.lua`)

#### Gitsigns (`lewis6991/gitsigns.nvim`)

**Features**:
- Git signs in gutter (add, change, delete, etc.)
- Inline git blame (enabled by default)
- Hunk navigation and management

**Configuration**:
```lua
opts = {
  current_line_blame = true,  -- Inline blame
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 1000,
  },
  signcolumn = true,
  max_file_length = 40000,  -- Disable for large files
}
```

#### LazyGit (`kdheepak/lazygit.nvim`)

Terminal UI for git commands.

---

### 5. Navigation (`navigation.lua`)

#### Harpoon 2 (`ThePrimeagen/harpoon`)

Quick file navigation with marks.

**Configuration**:
```lua
config = function()
  local harpoon = require("harpoon")
  harpoon:setup({
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
  })
end
```

#### Telescope (`nvim-telescope/telescope.nvim`)

Fuzzy finder with optimized settings.

**Configuration Highlights**:
- `hidden = true` in find_files (shows dotfiles)
- `live_grep` includes hidden files with `--hidden` flag
- `file_ignore_patterns`: `node_modules`, `.git/`, `dist`, `build`, `coverage`
- Horizontal layout with 0.55 preview width

#### UndoTree (`mbbill/undotree`)

Visual undo history tree.

**Configuration**:
```lua
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_WindowLayout = 2  -- Vertical split
vim.g.undotree_DiffAutoOpen = 1
vim.g.undotree_DiffpanelHeight = 15
```

---

### 6. Neo-tree (`neo-tree.lua`)

**Plugin**: `nvim-neo-tree/neo-tree.nvim`

File explorer with icons and git status.

**Configuration**:
```lua
opts = {
  window = {
    width = 38,  -- ~260px
  },
  filesystem = {
    filtered_items = {
      visible = true,           -- Show hidden files
      hide_dotfiles = false,     -- Don't hide dotfiles
      hide_gitignored = false,   -- Show gitignored files
      never_show = { ".git" },   -- Still hide .git directory
    },
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
  },
  git_status = {
    icons = { added = "✹", deleted = "✖", modified = "󰎆", ... }
  },
  source_selector = {
    sources = {
      { source = "filesystem", display_name = " 󰉓 Files" },
      { source = "buffers", display_name = " 󰌎 Buffers" },
      { source = "git_status", display_name = " 󰊢 Git" },
    },
  },
}
```

---

### 7. Spell Check (`spellcheck.lua`)

Code-aware spell checking for comments and text files.

**Enabled for**:
- Text files: `markdown`, `text`, `plaintex`, `tex`, `gitcommit`, `help`
- Code comments: `javascript`, `typescript`, `javascriptreact`, `typescriptreact`, `astro`, `vue`, `svelte`, `go`, `python`, `lua`, `rust`

**Configuration**:
```lua
command = function()
  vim.opt_local.spell = true
  vim.opt_local.spelllang = { "en_us" }
  vim.opt_local.spelloptions:append("camel")  -- CamelCase aware
end
```

---

### 8. Sudo Support (`sudo.lua`)

**Plugin**: `lambdalisue/suda.vim`

Edit root-owned files without losing plugins/config.

**Features**:
- `:SudaRead` / `:SudaWrite` commands
- Smart edit mode (auto-detects when sudo is needed)
- Notification when file is read-only

**Configuration**:
```lua
vim.g.suda_smart_edit = 1  -- Auto-detect sudo needed
vim.g.suda_always = 0      -- Don't always use sudo
```

---

### 9. Performance (`performance.lua`)

Optimizations for large projects.

**Large File Handling** (1MB+ or 10k+ lines):
- Disables: `spell`, `fold`, `conceal`, `lsp`, `treesitter`, `syntax`

**Treesitter**:
- Disabled for files > 100KB
- Auto-install missing parsers enabled

**LSP**:
- Codelens enabled with auto-refresh

**Mason**:
- Max concurrent installers: 4

**Neovim Options**:
- `updatetime = 250` (faster completion)
- `timeoutlen = 300` (faster which-key)

---

### 10. Mason Tools (`mason-tools.lua`)

Auto-installs LSP servers, formatters, and linters.

**LSP Servers**:
`typescript-language-server`, `tailwindcss-language-server`, `astro-language-server`, `prismals`, `gopls`, `yaml-language-server`, `docker-langserver`, `sql-language-server`, `bash-language-server`, `eslint-lsp`

**Formatters**:
`prettier`, `prettierd`, `stylua`

**Linters**:
`eslint_d`, `shellcheck`, `shfmt`, `markdownlint`, `json-lsp`

---

## Keybindings Reference

### General

| Keybinding | Mode | Action |
|------------|------|--------|
| `<C-d>` | Normal | Scroll down, center cursor |
| `<C-u>` | Normal | Scroll up, center cursor |
| `<leader>w` | Normal | Save file |
| `Q` | Normal | Close buffer |
| `<leader>y` | Normal/Visual | Yank to system clipboard |
| `<leader>p` | Normal/Visual | Paste from system clipboard |

### Git

| Keybinding | Action |
|------------|--------|
| `<leader>gg` | Open LazyGit |
| `<leader>gG` | LazyGit current file |
| `<leader>gb` | Toggle git blame |
| `<leader>hp` | Preview hunk |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hS` | Stage buffer |
| `<leader>hR` | Reset buffer |
| `<leader>hb` | Blame line (full) |
| `]h` | Next hunk |
| `[h` | Previous hunk |

### Navigation

**Harpoon**:

| Keybinding | Action |
|------------|--------|
| `<leader>a` | Add file to harpoon |
| `<C-e>` | Toggle harpoon menu |
| `<C-h>` | Select file 1 |
| `<C-t>` | Select file 2 |
| `<C-n>` | Select file 3 |
| `<C-s>` | Select file 4 |
| `<leader><C-h>` | Previous harpoon file |
| `<leader><C-l>` | Next harpoon file |

**Telescope**:

| Keybinding | Action |
|------------|--------|
| `<leader>ff` | Find files (include hidden) |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>fh` | Help tags |
| `<leader>fr` | Recent files |
| `<leader>fz` | Fuzzy find in buffer |

**UndoTree**:

| Keybinding | Action |
|------------|--------|
| `<leader>u` | Toggle UndoTree |

### Neo-tree

| Keybinding | Action |
|------------|--------|
| `<leader>e` | Toggle Neo-tree |
| `<leader>o` | Focus Neo-tree |
| `<leader>b` | Toggle buffer list |
| `<leader>g` | Toggle git status |

### Formatting & Linting

| Keybinding | Action |
|------------|--------|
| `<leader>cf` | Format file |
| `<leader>lf` | Lint file |

### Spell Check

| Keybinding | Action |
|------------|--------|
| `<leader>ts` | Toggle spell check |
| `]s` | Next spell error |
| `[s` | Previous spell error |
| `z=` | Spell suggestions |

### Sudo

| Keybinding | Action |
|------------|--------|
| `<leader>sw` | Sudo write |
| `<leader>sr` | Sudo read |

---

## LSP Servers

### TypeScript/JavaScript (`ts_ls`)

- **Package**: `typescript-language-server`
- **Filetypes**: `javascript`, `javascriptreact`, `typescript`, `typescriptreact`, `jsx`, `tsx`
- **Features**: Auto-complete, diagnostics, go-to-definition, rename, refactoring

### Go (`gopls`)

- **Package**: `gopls`
- **Filetypes**: `go`, `gomod`, `gowork`, `gosum`
- **Features**: Auto-complete, diagnostics, go-to-definition, code actions

### TailwindCSS (`tailwindcss`)

- **Package**: `tailwindcss-language-server`
- **Filetypes**: `html`, `css`, `scss`, `javascript`, `typescript`, `tsx`, `jsx`, `astro`, `mdx`
- **Features**: Class name completion, hover info, color preview

### YAML (`yamlls`)

- **Package**: `yaml-language-server`
- **Features**: Schema validation, auto-complete, hover info
- **Schemas**: GitHub Actions, Docker Compose, Prettier

### Prisma (`prismals`)

- **Package**: `prismals`
- **Filetypes**: `prisma`
- **Features**: Syntax highlighting, auto-complete, diagnostics

### Docker (`dockerls`)

- **Package**: `docker-langserver`
- **Filetypes**: `dockerfile`
- **Features**: Syntax checking, auto-complete

### PostgreSQL (`sqlls`)

- **Package**: `sql-language-server`
- **Filetypes**: `sql`
- **Features**: Auto-complete, diagnostics, go-to-definition

### Bash (`bashls`)

- **Package**: `bash-language-server`
- **Filetypes**: `bash`, `sh`
- **Features**: Auto-complete, diagnostics, hover info

---

## Mason Tools

### Auto-Installation

Mason automatically installs these tools on startup:

```lua
ensure_installed = {
  -- LSP servers
  "typescript-language-server",
  "tailwindcss-language-server",
  "astro-language-server",
  "prismals",
  "gopls",
  "yaml-language-server",
  "docker-langserver",
  "sql-language-server",
  "bash-language-server",
  "eslint-lsp",

  -- Formatters
  "prettier",
  "prettierd",
  "stylua",

  -- Linters
  "eslint_d",
  "shellcheck",
  "shfmt",
  "markdownlint",
  "json-lsp",
}
```

### Manual Mason Commands

| Command | Description |
|---------|-------------|
| `:Mason` | Open Mason UI |
| `:MasonInstall <package>` | Install a package |
| `:MasonUninstall <package>` | Uninstall a package |
| `:MasonLog` | View Mason log |

---

## Formatting & Linting

### Prettier Configuration

```json
{
  "printWidth": 100,
  "tabWidth": 4,
  "singleQuote": false,
  "trailingComma": "es5"
}
```

These settings are passed via command-line arguments in `conform.nvim`.

### ESLint Auto-fix

ESLint is configured to auto-fix on save for JavaScript/TypeScript files. This is handled by the LazyVim typescript extra which configures the eslint LSP server.

### No Conflicts Policy

- **Formatting**: Prettier is the primary formatter
- **Linting**: ESLint runs separately via nvim-lint
- **Order**: Format on save happens first, then lint diagnostics are shown

---

## Troubleshooting

### LSP Not Working

1. Check if the LSP server is installed: `:LspInfo`
2. Install missing servers: `:Mason`
3. Restart LSP: `:LspRestart`

### Formatting Not Working

1. Check conform.nvim: `:ConformInfo`
2. Manually format: `:Format`
3. Check if formatter is installed: `:Mason`

### Treesitter Parsers Missing

1. Install parser: `:TSInstall <language>`
2. Check installed: `:TSInstallInfo`
3. Enable auto-install: Already enabled in config

### Theme Not Loading

1. Check if aether.nvim is installed: `:Lazy`
2. Manually set colorscheme: `:colorscheme aether`
3. Clear cache: `:Lazy clear`

### Performance Issues

1. Check large file settings in `performance.lua`
2. Disable plugins temporarily
3. Check startup time: `:Lazy profile`

---

## Customization Guide

### Adding a New Language

1. Add LSP server in `lua/plugins/lsp.lua`:
   ```lua
   servers = {
     newlsp = { filetypes = { "newlang" } }
   }
   ```

2. Add treesitter parser:
   ```lua
   vim.list_extend(opts.ensure_installed, { "newlang" })
   ```

3. Add formatter/linters in `lua/plugins/formatting-linting.lua`

4. Add to Mason in `lua/plugins/mason-tools.lua`

### Changing Keybindings

Edit the respective plugin file in `lua/plugins/` or add to `lua/config/keymaps.lua`.

### Modifying Theme

Edit `lua/plugins/colorscheme.lua` and modify the `colors` table or `on_highlights` function.

---

## File Type Detection

The configuration supports these file types automatically:

| Extension | Filetype |
|-----------|----------|
| `.ts`, `.tsx` | `typescript`, `typescriptreact` |
| `.js`, `.jsx` | `javascript`, `javascriptreact` |
| `.astro` | `astro` |
| `.mdx` | `mdx` |
| `.go` | `go` |
| `.prisma` | `prisma` |
| `.sql` | `sql` |
| `.yaml`, `.yml` | `yaml` |
| `Dockerfile` | `dockerfile` |
| `.sh`, `.bash` | `bash` |

---

## Credits

- **LazyVim**: https://www.lazyvim.org/
- **lazy.nvim**: https://github.com/folke/lazy.nvim
- **Aether Theme**: https://github.com/bjarneo/aether.nvim

---

*Last updated: 2026-05-03*
