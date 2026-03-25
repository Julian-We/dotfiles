-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move window management from <leader>w to <leader>W.
-- LazyVim sets these individually; delete them so they don't shadow <leader>w → save.
pcall(vim.keymap.del, "n", "<leader>ww")
pcall(vim.keymap.del, "n", "<leader>wd")
pcall(vim.keymap.del, "n", "<leader>w-")
pcall(vim.keymap.del, "n", "<leader>w|")
pcall(vim.keymap.del, "n", "<leader>wm")

vim.keymap.set("n", "<leader>Ww", "<C-W>p", { desc = "Other Window", remap = true })
vim.keymap.set("n", "<leader>Wd", "<C-W>c", { desc = "Delete Window", remap = true })
vim.keymap.set("n", "<leader>W-", "<C-W>s", { desc = "Split Window Below", remap = true })
vim.keymap.set("n", "<leader>W|", "<C-W>v", { desc = "Split Window Right", remap = true })
vim.keymap.set("n", "<leader>Wm", function()
  Snacks.toggle.maximize():toggle()
end, { desc = "Maximize Toggle" })

-- Save file
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save File" })

-- Run Python file in a terminal split
vim.keymap.set("n", "<leader>rr", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("botright 15split | terminal python3 " .. vim.fn.shellescape(file))
end, { desc = "Run Python in split" })

-- Neotest + DAP variants (standard neotest keymaps are <leader>t* via the Python extra)
vim.keymap.set("n", "<leader>dM", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "Test Nearest (DAP)" })

vim.keymap.set("n", "<leader>dF", function()
  require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
end, { desc = "Test File (DAP)" })
