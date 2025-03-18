require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-f>", "<cmd>silent !tmux neww sessionizer<CR>")
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
