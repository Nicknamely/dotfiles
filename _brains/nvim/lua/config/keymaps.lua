-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
-- map("n", "<leader>fp", "<cmd>NeovimProjectDiscover<cr>", { desc = "Browse Project" })
map("i", "<C-v>", '<Esc>"+p', { desc = "Paste" })
-- map("i", "<C-BS>", "<C-o>db", { desc = "Delete backward word" })
-- map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "new buffer" })
