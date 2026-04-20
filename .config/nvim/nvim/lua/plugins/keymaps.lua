return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        -- <leader>W becomes the window-management group with the <C-w> proxy
        { "<leader>W", proxy = "<c-w>", group = "windows", icon = { icon = "󱂬", color = "blue" } },
        -- Override the old <leader>w group to remove the proxy and reflect the new purpose
        { "<leader>w", group = "save", icon = { icon = "󰆓", color = "green" } },
      },
    },
  },
}
