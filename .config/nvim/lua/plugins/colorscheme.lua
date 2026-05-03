-- Everforest theme configuration
return {
  {
    "neanias/everforest-nvim",
    lazy = false,
    priority = 1000,
    opts = {
      -- Available options: "hard", "medium" (default), "soft"
      background = "hard",
      -- Available options: "dark" (default), "light"
      dark = true,
      -- Transparent background
      transparent = false,
      -- Italic options
      italics = {
        comments = true,
        strings = false,
        folds = true,
        operators = false,
        keywords = false,
        functions = false,
        variables = false,
      },
      -- Colors palette override (optional)
      colors = {
        -- Uncomment to customize:
        -- bg0 = "#2d353b",
        -- bg1 = "#343f44",
        -- bg2 = "#3d484d",
        -- bg3 = "#475258",
        -- bg4 = "#565f64",
        -- fg0 = "#d3c6aa",
        -- fg1 = "#c8bb93",
        -- red = "#e67e80",
        -- orange = "#e69875",
        -- yellow = "#dbbc7f",
        -- green = "#a7c080",
        -- blue = "#7fbbb3",
        -- purple = "#d699b6",
        -- aqcua = "#83c092",
        -- gray = "#859289",
      },
      -- Override specific highlight groups (optional)
      on_highlights = function(hl, colors)
        hl.CursorLine = { bg = "#3d484d" }
        hl.CursorLineNr = { fg = colors.orange, bold = true }
      end,
    },
    config = function(_, opts)
      require("everforest").setup(opts)
      vim.cmd.colorscheme("everforest")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
