-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = ""
vim.opt.wrap = true
vim.cmd.colorscheme("default") -- Falls back to Neovim's basic layout
vim.opt.termguicolors = false -- Tells Neovim to respect the terminal's 16/256 ANSI colors
vim.cmd("set t_Co=256") -- Ensures 256 terminal color compatibility

-- Enable system clipboard integration
-- vim.opt.clipboard = "unnamedplus"
