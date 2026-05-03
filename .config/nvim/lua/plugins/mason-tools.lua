-- Mason tools auto-setup for all languages
-- Automatically installs required LSP servers, formatters, and linters

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers
        "typescript-language-server", -- TypeScript/JavaScript/React/Next.js
        "tailwindcss-language-server", -- TailwindCSS
        "astro-language-server", -- Astro
        "prisma-language-server", -- Prisma
        "gopls", -- Go (Golang)
        "yaml-language-server", -- YAML
        "dockerfile-language-server", -- Docker
        "bash-language-server", -- Bash/Shell scripts
        "eslint-lsp", -- ESLint

        -- Formatters
        "prettier", -- Prettier (for JS, TS, HTML, CSS, Markdown, etc.)
        "prettierd", -- Prettier daemon (faster)
        "stylua", -- Lua formatter

        -- Linters
        "eslint_d", -- ESLint daemon (faster)
        "shellcheck", -- Shell script linter
        "shfmt", -- Shell script formatter

        -- Additional tools
        "markdownlint", -- Markdown linter
        "json-lsp", -- JSON LSP
      },
    },
  },

  -- Auto-setup Mason tools on LazyVim startup
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- Automatically install configured LSP servers
      automatic_installation = true,
      -- LSP server to Mason package mapping (if different from default)
      ensure_installed = {
        "ts_ls",
        "tailwindcss",
        "astro",
        "prisma-language-server",
        "gopls",
        "yamlls",
        "dockerls",
        "sqlls",
        "bashls",
        "eslint",
      },
    },
  },
}
