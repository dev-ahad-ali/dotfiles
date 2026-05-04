-- LSP configuration for all required languages
-- TypeScript, JavaScript, React, Next.js, Astro, MDX, Go, etc.

return {
  -- TypeScript/JavaScript/React/Next.js support via LazyVim extras
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- Astro support
  { import = "lazyvim.plugins.extras.lang.astro" },

  -- Go support
  { import = "lazyvim.plugins.extras.lang.go" },

  -- JSON support (for config files, package.json, etc.)
  { import = "lazyvim.plugins.extras.lang.json" },

  -- YAML support (for Docker, Kubernetes, GitHub Actions, etc.)
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        -- YAML LSP
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://json.schemastore.org/docker-compose.json"] = "/docker-compose*.yml",
                ["https://json.schemastore.org/prettierrc.json"] = "/.prettierrc",
              },
            },
          },
        },
        -- Prisma LSP
        prismals = {},
        -- TailwindCSS LSP
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "tsx",
            "jsx",
            "astro",
            "mdx",
          },
          init_options = {
            userLanguages = {
              eel = "html-eex",
              erb = "html-eex",
              heex = "html-eex",
              svelte = "html",
              astro = "html",
              mdx = "markdown",
            },
          },
        },
        -- Docker LSP
        dockerls = {},
        -- SQL (PostgreSQL) LSP
        sqlls = {
          cmd = { "sql-language-server", "up", "--method", "stdio" },
        },
        -- Bash LSP for shell scripts
        bashls = {},
        -- React Native / Expo support (uses tsserver with additional filetypes)
        tsserver = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
        },
      },
    },
  },

  -- Treesitter parsers for all required languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "typescript",
        "tsx",
        "javascript",
        "html",
        "css",
        "scss",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "astro",
        "mdx",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "prisma",
        "dockerfile",
        "sql",
        "bash",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "regex",
      })
    end,
  },

  -- MDX support
  {
    "davidmh/mdx.nvim",
    event = "BufEnter *.mdx",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
}
