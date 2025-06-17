return {
  {
    "catppuccin/nvim",
    opts = function()
      local options = {
        term_colors = true,
        -- custom_highlights = function(colors)
        --   return {
        --     NormalFloat = { bg = colors.base, fg = colors.text },
        --   }
        -- end,
      }
      if vim.g.neovide then
        options.transparent_background = false
      else
        options.transparent_background = true
      end
      return options
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
