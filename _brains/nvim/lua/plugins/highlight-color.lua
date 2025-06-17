return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    render = "background", -- or "foreground", "first_column"
    virtual_symbol = "●",
    enable_tailwind = true, -- Tailwind class colors
    enable_named_colors = true, -- support for color names like 'red'
    enable_var_usage = false,
  },
}
