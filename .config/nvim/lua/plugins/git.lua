-- Git integration: blame, signs, and LazyGit
return {
  -- Git signs in gutter (already included in LazyVim, but ensure it's enabled)
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      signcolumn = true, -- Show signs in sign column
      numhl = false, -- Disable number highlight
      linehl = false, -- Disable line highlight
      word_diff = false, -- Disable word diff
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = true, -- Enable inline git blame
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- Show at end of line
        delay = 1000, -- Delay before showing blame
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is too large
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
    keys = {
      -- Toggle inline git blame
      { "<leader>gb", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle Git Blame" },
      -- Preview git hunk
      { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview Hunk" },
      -- Stage hunk
      { "<leader>hs", function() require("gitsigns").stage_hunk() end, desc = "Stage Hunk" },
      -- Reset hunk
      { "<leader>hr", function() require("gitsigns").reset_hunk() end, desc = "Reset Hunk" },
      -- Stage buffer
      { "<leader>hS", function() require("gitsigns").stage_buffer() end, desc = "Stage Buffer" },
      -- Reset buffer
      { "<leader>hR", function() require("gitsigns").reset_buffer() end, desc = "Reset Buffer" },
      -- Blame line
      { "<leader>hb", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame Line" },
      -- Navigate hunks
      { "]h", function() require("gitsigns").next_hunk() end, desc = "Next Hunk" },
      { "[h", function() require("gitsigns").prev_hunk() end, desc = "Prev Hunk" },
    },
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gG", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
    },
    opts = {
      -- LazyGit config
    },
  },
}
