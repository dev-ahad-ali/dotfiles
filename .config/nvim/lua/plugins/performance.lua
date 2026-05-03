-- Performance optimizations for large projects
-- Smart defaults to keep Neovim fast

return {
  -- LazyVim performance settings
  {
    "LazyVim/LazyVim",
    opts = {
      -- Disable some features for large files
      large_file = {
        size = 1024 * 1024, -- 1MB
        lines = 10000,
        features = {
          "spell",
          "fold",
          "conceal",
          "lsp",
          "treesitter",
          "syntax",
        },
      },
    },
  },

  -- Treesitter performance optimizations
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
        -- Disable for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<S-CR>",
          node_decremental = "<BS>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
      -- Only load parsers on demand
      ensure_installed = {},
      auto_install = true, -- Auto-install missing parsers
      sync_install = false,
    },
  },

  -- LSP performance optimizations
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Default LSP settings for better performance
      defaults = {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = true,
              },
            },
          },
        },
      },
      -- Codelens (references, implementations)
      codelens = {
        enable = true,
        refresh_on_start = true,
        refresh_on_events = { "BufEnter", "CursorHold", "InsertLeave" },
      },
    },
  },

  -- Reduce updatetime for better CursorHold performance
  {
    "LazyVim/LazyVim",
    opts = {
      options = {
        updatetime = 250, -- Faster completion and linting
        timeoutlen = 300, -- Faster which-key
      },
    },
  },

  -- Mason performance: only install what's needed
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      max_concurrent_installers = 4, -- Limit concurrent installs
    },
  },
}
