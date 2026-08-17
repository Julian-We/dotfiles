return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- make sure the default list exists
    opts.ensure_installed = opts.ensure_installed or {}

    -- add javascript if it isn’t already there
    vim.list_extend(opts.ensure_installed, { "javascript" })

    -- optional: enable highlight for the new filetype (it’s automatic)
    opts.highlight = opts.highlight or {}
    opts.highlight.enable = true

    return opts
  end,
}
