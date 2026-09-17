return {
  -- dressing.nvim for improved vim.ui.select / vim.ui.input
  { "stevearc/dressing.nvim", opts = {} },

  -- neotest-python: match original runner/dap settings
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-python" },
    opts = {
      adapters = {
        ["neotest-python"] = {
          dap = { justMyCode = false, console = "integratedTerminal" },
          args = { "--log-level", "DEBUG", "--quiet" },
          runner = "pytest",
        },
      },
    },
  },

  -- ruff: ignore E203 ("whitespace before ':'", suppressed when using black)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruff = {
          init_options = {
            settings = {
              lint = { ignore = { "E203" } },
            },
          },
        },
      },
    },
  },
}
