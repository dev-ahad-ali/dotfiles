-- Formatting and linting configuration
-- Uses LazyVim's built-in conform.nvim (formatting) and nvim-lint (linting)
-- Prettier: printWidth=100, tabWidth=4
-- ESLint: auto-fix on save via LSP

return {
  -- Conform.nvim configuration for formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- JavaScript/TypeScript/React/Next.js/Astro/MDX
        javascript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        -- HTML/CSS/Tailwind
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        -- Astro
        astro = { "prettierd", "prettier" },
        -- MDX
        mdx = { "prettierd", "prettier" },
        -- JSON/YAML
        json = { "prettierd", "prettier" },
        jsonc = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        -- Markdown
        markdown = { "prettierd", "prettier" },
        -- Go
        go = { "goimports", "gofmt" },
        -- Lua
        lua = { "stylua" },
        -- SQL
        sql = { "sqlfmt" },
      },
      formatters = {
        prettier = {
          prepend_args = { "--print-width", "100", "--tab-width", "4" },
        },
        prettierd = {
          prepend_args = { "--print-width", "100", "--tab-width", "4" },
        },
      },
      -- Auto-format on save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- nvim-lint configuration for linting (Go, YAML, Docker, Shell)
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- Go
        go = { "golangcilint" },
        -- YAML
        yaml = { "yamllint" },
        -- Docker
        dockerfile = { "hadolint" },
        -- Shell
        sh = { "shellcheck" },
        bash = { "shellcheck" },
      },
    },
  },

  -- ESLint auto-fix on save (uses ESLint LSP server, not nvim-lint)
  -- This is handled by the LazyVim extras.lang.typescript import
  -- which configures the eslint LSP with auto-fix on save

  -- Keybindings for formatting/linting
  keys = {
    { "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format File" },
    { "<leader>lf", function() require("lint").try_lint() end, desc = "Lint File" },
  },
}
