return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
      "jpalardy/vim-slime",
    },
    opts = {
      lspFeatures = {
        enabled = true,
        chunks = "curly",
        languages = { "python" },
        diagnostics = { enabled = true, triggers = { "BufWritePost" } },
        completion = { enabled = true },
      },
      codeRunner = {
        enabled = true,
        default_method = "slime",
        ft_runners = {},
        never_run = { "yaml" },
      },
    },
    keys = {
      {
        "<leader>rc",
        function()
          require("quarto.runner").run_cell()
        end,
        ft = "quarto",
        desc = "Run Cell",
      },
      {
        "<leader>ra",
        function()
          require("quarto.runner").run_above()
        end,
        ft = "quarto",
        desc = "Run Cell and Above",
      },
      {
        "<leader>rA",
        function()
          require("quarto.runner").run_all()
        end,
        ft = "quarto",
        desc = "Run All Cells",
      },
      {
        "<leader>rl",
        function()
          require("quarto.runner").run_line()
        end,
        ft = "quarto",
        desc = "Run Line",
      },
      {
        "<leader>rv",
        function()
          require("quarto.runner").run_range()
        end,
        mode = "v",
        ft = "quarto",
        desc = "Run Visual Range",
      },
    },
  },

  { "jmbuhr/otter.nvim", opts = {} },

  -- vim-slime: send Quarto/Python cell code to a terminal REPL
  {
    "jpalardy/vim-slime",
    ft = { "quarto", "python" },
    init = function()
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1
    end,
  },

  -- extra treesitter parsers Quarto docs need
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline", "yaml" })
      return opts
    end,
  },
}
