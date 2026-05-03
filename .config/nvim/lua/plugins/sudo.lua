-- Sudo editing support
-- Allows editing root-owned files without losing plugins/config
-- Uses lambdalisue/suda.vim (also known as vim-suda)

return {
  {
    "lambdalisue/suda.vim",
    cmd = { "SudaRead", "SudaWrite" },
    keys = {
      -- Keybinding for sudo write
      { "<leader>sw", "<cmd>SudaWrite<cr>", desc = "Sudo Write" },
      { "<leader>sr", "<cmd>SudaRead<cr>", desc = "Sudo Read" },
    },
    config = function()
      vim.g.suda_smart_edit = 1 -- Enable smart edit (auto-detect sudo needed)
      vim.g.suda_always = 0 -- Don't always use sudo
    end,
    init = function()
      -- Auto-detect when we need sudo
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("SudoAutoDetect", { clear = true }),
        pattern = "*",
        callback = function()
          local bufname = vim.api.nvim_buf_get_name(0)
          if bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
            local perms = vim.fn.getfperm(bufname)
            if perms ~= "" and not string.find(perms, "w") then
              vim.notify(
                "File is read-only. Use :SudaWrite or <leader>sw to save with sudo",
                vim.log.levels.WARN
              )
            end
          end
        end,
      })
    end,
  },
}
