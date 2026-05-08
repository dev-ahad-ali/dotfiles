return {
  {
    "daschw/leaf.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("leaf").setup({
        {
          underlineStyle = "underline",
          commentStyle = "italic",
          functionStyle = "NONE",
          keywordStyle = "italic",
          statementStyle = "bold",
          typeStyle = "NONE",
          variablebuiltinStyle = "italic",
          transparent = false,
          colors = {},
          overrides = {},
          theme = "light", -- default, based on vim.o.background, alternatives: "light", "dark"
          contrast = "low", -- default, alternatives: "medium", "high"
        },
      })
      require("leaf").load()
    end,
  },
}
