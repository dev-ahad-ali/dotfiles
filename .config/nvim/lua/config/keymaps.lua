-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<C-d>", "m`<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "m`<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save File" })
vim.keymap.set("n", "Q", "<cmd>bd<CR>", { desc = "Close Buffer" })

-- Map <leader>y to yank to system clipboard
-- vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to System Clipboard" })

-- Map <leader>p to paste from system clipboard
-- vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from System Clipboard" })
-- vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from System Clipboard" })
