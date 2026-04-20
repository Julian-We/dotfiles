return {
  {
    "nvim-mini/mini.map",
    version = false,
    keys = {
      { "<leader>um", function() require("mini.map").toggle() end, desc = "Toggle Minimap" },
      { "<leader>uM", function() require("mini.map").toggle_focus() end, desc = "Focus Minimap" },
    },
    config = function()
      local map = require("mini.map")

      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diagnostic(),
          map.gen_integration.gitsigns(),
        },
        window = {
          side = "right",
          width = 10,
          winblend = 15,
        },
      })

      local function is_supported_buffer(bufnr)
        local buftype = vim.bo[bufnr].buftype
        if buftype ~= "" and buftype ~= "help" then
          return false
        end

        local filetype = vim.bo[bufnr].filetype
        return filetype ~= "snacks_dashboard" and filetype ~= "lazy"
      end

      local function sync_minimap_to_active_window()
        local win = vim.api.nvim_get_current_win()
        if vim.api.nvim_win_get_config(win).relative ~= "" then
          return
        end

        if not is_supported_buffer(vim.api.nvim_get_current_buf()) then
          map.close()
          return
        end

        map.open()
        map.refresh()
      end

      local group = vim.api.nvim_create_augroup("minimap_active_window", { clear = true })
      vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "WinEnter" }, {
        group = group,
        callback = sync_minimap_to_active_window,
      })
    end,
  },
}
