return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      -- NOTE will extend default installed language instead of
      -- overwritting it.
      vim.list_extend(opts.ensure_installed, {
        --"typescript",
        "css",
        "scss",
        "latex",
        "norg",
        "svelte",
        "typst",
        "vue",
        "qmljs",
      })
    end,
  },
}
