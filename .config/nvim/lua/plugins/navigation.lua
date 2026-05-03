-- Navigation and productivity tools
-- Harpoon, Telescope optimizations, and UndoTree

return {
  -- Harpoon for quick file navigation
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        },
      })

      -- Keybindings
      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end, { desc = "Harpoon Add File" })

      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon Quick Menu" })

      vim.keymap.set("n", "<C-h>", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon to File 1" })

      vim.keymap.set("n", "<C-t>", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon to File 2" })

      vim.keymap.set("n", "<C-n>", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon to File 3" })

      vim.keymap.set("n", "<C-s>", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon to File 4" })

      -- Navigate to previous/next buffer in harpoon list
      vim.keymap.set("n", "<leader><C-h>", function()
        harpoon:list():prev()
      end, { desc = "Harpoon Prev" })

      vim.keymap.set("n", "<leader><C-l>", function()
        harpoon:list():next()
      end, { desc = "Harpoon Next" })
    end,
  },

  -- Telescope optimized configuration
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules", ".git/", "dist", "build", "coverage", "*.log" },
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        live_grep = {
          --@usage don't include the filename in the search results
          only_sort_text = true,
        },
      },
      pickers = {
        find_files = {
          hidden = true, -- Show hidden files (dotfiles)
          no_ignore = false,
        },
        live_grep = {
          additional_args = function(opts)
            return { "--hidden" }
          end,
        },
      },
    },
    keys = {
      -- Additional Telescope keybindings
      { "<leader>ff", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find Files (Include Hidden)" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Find in Buffer" },
    },
  },

  -- UndoTree integration
  {
    "mbbill/undotree",
    cmd = { "UndotreeToggle", "UndotreeShow", "UndotreeHide", "UndotreeFocus" },
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle UndoTree" },
    },
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_WindowLayout = 2 -- Split vertically
      vim.g.undotree_DiffAutoOpen = 1
      vim.g.undotree_DiffpanelHeight = 15
      vim.g.undotree_ShortIndicators = 1
      vim.g.undotree_HelpLine = 0
    end,
  },
}
