-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-d>", "m`<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "m`<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save File" })
vim.keymap.set("n", "Q", "<cmd>bd<CR>", { desc = "Close Buffer" })
