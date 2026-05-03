-- Code-aware spell checking
-- Spell check for comments, markdown, and text files

return {
  -- Configure spell check for specific filetypes
  {
    "LazyVim/LazyVim",
    opts = {
      -- Enable spell check for text-based filetypes
      autocmds = {
        -- Spell check for text files, markdown, git commits
        spell_check = {
          {
            event = "FileType",
            pattern = { "markdown", "text", "plaintex", "tex", "gitcommit", "help" },
            command = function()
              vim.opt_local.spell = true
              vim.opt_local.spelllang = { "en_us" }
            end,
          },
          -- Spell check for comments in code files
          spell_check_comments = {
            event = "FileType",
            pattern = {
              "javascript",
              "typescript",
              "javascriptreact",
              "typescriptreact",
              "astro",
              "vue",
              "svelte",
              "go",
              "python",
              "lua",
              "rust",
            },
            command = function()
              vim.opt_local.spell = true
              vim.opt_local.spelllang = { "en_us" }
              -- Only spell check comments
              vim.opt_local.spelloptions:append("camel")
            end,
          },
        },
      },
    },
  },

  -- Enhanced spell checking with visual indicators
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      -- Add spell check keybinding
      opts.keymaps = opts.keymaps or {}
      table.insert(opts.keymaps, {
        mode = "n",
        key = "<leader>ts",
        action = function()
          vim.opt.spell = not vim.opt.spell:get()
          vim.notify("Spell check: " .. (vim.opt.spell:get() and "ON" or "OFF"))
        end,
        desc = "Toggle Spell Check",
      })
      return opts
    end,
  },

  -- Keybindings for spell check
  {
    "LazyVim/LazyVim",
    opts = {
      keymaps = {
        -- Spell check navigation
        ["]s"] = { function() vim.cmd("normal! ]s") end, desc = "Next Spell Error" },
        ["[s"] = { function() vim.cmd("normal! [s") end, desc = "Prev Spell Error" },
        -- Spell suggestions
        ["z="] = { function() vim.cmd("normal! z=") end, desc = "Spell Suggestions" },
      },
    },
  },
}
