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

-- Run Python file in a terminal split (reuses existing python-runner terminal)
vim.keymap.set("n", "<leader>rr", function()
  local file = vim.fn.expand("%:p")
  local term_buf = nil
  local term_win = nil

  -- Find existing terminal buffer named "python-runner"
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name:match("python%-runner") then
        term_buf = buf
        -- Check if this buffer is visible in any window
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == buf then
            term_win = win
            break
          end
        end
        break
      end
    end
  end

  if term_buf and term_win then
    -- Terminal exists and is visible, send new command to it
    vim.api.nvim_set_current_win(term_win)
    vim.cmd("startinsert")
    vim.api.nvim_chan_send(vim.bo[term_buf].channel, "python " .. vim.fn.shellescape(file) .. "\n")
  elseif term_buf then
    -- Terminal exists but not visible, show it in a split
    vim.cmd("botright 15split")
    vim.api.nvim_set_current_buf(term_buf)
    vim.cmd("startinsert")
    vim.api.nvim_chan_send(vim.bo[term_buf].channel, "python " .. vim.fn.shellescape(file) .. "\n")
  else
    -- No terminal exists, create one with a custom name
    vim.cmd("botright 15split | terminal")
    vim.api.nvim_buf_set_name(0, "term://python-runner")
    vim.cmd("startinsert")
    vim.api.nvim_chan_send(vim.bo.channel, "python " .. vim.fn.shellescape(file) .. "\n")
  end
end, { desc = "Run Python in split" })

-- Neotest + DAP variants (standard neotest keymaps are <leader>t* via the Python extra)
vim.keymap.set("n", "<leader>dM", function()
  require("neotest").run.run({ strategy = "dap" })
end, { desc = "Test Nearest (DAP)" })

vim.keymap.set("n", "<leader>dF", function()
  require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
end, { desc = "Test File (DAP)" })

-- Remap <leader>/ to toggle line comment
-- The default LazyVim <leader>/ is for grep, which we'll move to <leader>sg below
vim.keymap.set("n", "<leader>/", "gcc", { desc = "Toggle Line Comment", remap = true })
vim.keymap.set("v", "<leader>/", "gc", { desc = "Toggle Comment", remap = true })

-- Move the original grep functionality to <leader>sg
vim.keymap.set("n", "<leader>sg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Grep (Root Dir)" })
