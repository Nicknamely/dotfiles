return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = "catppuccin" -- Set Catppuccin as the theme
      opts.options.section_separators = { left = "", right = "" } -- Optional: Rounded separators
      opts.options.component_separators = { left = "", right = "" } -- Optional: Rounded separators
    end,
  },
}
