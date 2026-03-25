return {
  -- dressing.nvim for improved vim.ui.select / vim.ui.input
  { "stevearc/dressing.nvim", opts = {} },

  -- iPython REPL via iron.nvim — send lines/paragraphs/selections piece by piece
  {
    "Vigemus/iron.nvim",
    ft = "python",
    keys = {
      { "<leader>ri", "<cmd>IronRepl<cr>",    desc = "Open iPython REPL", ft = "python" },
      { "<leader>rR", "<cmd>IronRestart<cr>", desc = "Restart REPL",      ft = "python" },
    },
    config = function()
      require("iron.core").setup({
        config = {
          scratch_repl = true,
          repl_definition = {
            python = { command = { "ipython", "--no-autoindent" } },
          },
          repl_open_cmd = "botright 15split",
        },
        -- <leader>r* keymaps active in Python buffers
        keymaps = {
          send_motion    = "<leader>rc",
          visual_send    = "<leader>rc",
          send_line      = "<leader>rl",
          send_paragraph = "<leader>rp",
          send_file      = "<leader>rF",
          exit           = "<leader>rq",
          clear          = "<leader>rx",
        },
        highlight = { italic = true },
        ignore_blank_lines = true,
      })
    end,
  },

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
