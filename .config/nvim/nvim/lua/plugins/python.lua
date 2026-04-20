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

  -- molten.nvim for Jupyter notebook integration
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "3rd/image.nvim", -- optional: for image rendering
    },
    ft = { "python", "markdown" },
    keys = {
      { "<leader>mi", "<cmd>MoltenInit<cr>", desc = "Initialize Molten", ft = { "python", "markdown" } },
      { "<leader>me", "<cmd>MoltenEvaluateOperator<cr>", desc = "Evaluate Operator", ft = { "python", "markdown" } },
      { "<leader>ml", "<cmd>MoltenEvaluateLine<cr>", desc = "Evaluate Line", ft = { "python", "markdown" } },
      { "<leader>mr", "<cmd>MoltenReevaluateCell<cr>", desc = "Re-evaluate Cell", ft = { "python", "markdown" } },
      { "<leader>mv", ":<C-u>MoltenEvaluateVisual<cr>", mode = "v", desc = "Evaluate Visual", ft = { "python", "markdown" } },
      { "<leader>md", "<cmd>MoltenDelete<cr>", desc = "Delete Cell", ft = { "python", "markdown" } },
      { "<leader>mh", "<cmd>MoltenHideOutput<cr>", desc = "Hide Output", ft = { "python", "markdown" } },
      { "<leader>mo", "<cmd>MoltenShowOutput<cr>", desc = "Show Output", ft = { "python", "markdown" } },
    },
    init = function()
      -- Molten configuration
      vim.g.molten_auto_open_output = false
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end,
  },

  -- image.nvim for displaying images in molten output (optional)
  {
    "3rd/image.nvim",
    optional = true,
    opts = {
      backend = "kitty", -- or "ueberzug" depending on your terminal
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
        },
      },
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
    },
  },
}
