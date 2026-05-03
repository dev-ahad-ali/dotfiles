return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false, -- Disable scrolling animations
    },
    explorer = {
      replace_netrw = true,
      width = 31,
      hidden = true,
      ignored = true,
      exclude = { ".git" },
      follow_file = true,
      git_status = true,
      diagnostics = true,
      trash = true,
    },
  },
  keys = {
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>o", function() Snacks.explorer() end, desc = "Focus File Explorer" },
    { "<leader>b", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>g", function() Snacks.picker.git_status() end, desc = "Git Status" },
  },
}
