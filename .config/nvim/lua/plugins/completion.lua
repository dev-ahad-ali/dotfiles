-- Completion setup (blink.cmp - LazyVim default)
-- Auto-completion with snippets support.

return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      require("luasnip.loaders.from_vscode").lazy_load()

      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = { name = "LSP", enabled = true, module = "blink.cmp.sources.lsp", opts = {} },
          path = { name = "Path", enabled = true, module = "blink.cmp.sources.path", opts = {} },
          snippets = { name = "Snippets", enabled = true, module = "blink.cmp.sources.snippets", opts = {} },
          buffer = {
            name = "Buffer", enabled = true, module = "blink.cmp.sources.buffer",
            opts = {
              get_bufnrs = function()
                return vim.iter(vim.api.nvim_list_bufs()):filter(function(bufnr)
                  return vim.bo[bufnr].buftype ~= "nofile"
                end):totable()
              end,
            },
          },
        },
      })

      opts.snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
      }

      return opts
    end,
    dependencies = {
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "L3MON4D3/LuaSnip",
    opts = {
      history = true,
      update_events = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged",
    },
  },
}
