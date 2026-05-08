return {
  {
    "daschw/leaf.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("leaf").setup({
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
        theme = "light",
        contrast = "low",
      })
      require("leaf").load()
    end,
  },
}
